library(sf) 
SciViews::R()

chart.sf <- function(data, specif = aes(), formula = NULL, mapping = aes(), type = NULL, theme = theme_svmap, env = parent.frame()) {
  if (!missing(specif))
    if (inherits(specif, "formula")) {
      formula <- specif
    } else if (inherits(specif, "uneval")) {
      mapping <- specif
    } else rlang::abort("'specif' must be either a formula or aes()/f_aes()")
  if (!is.null(formula)) {
    args <- chart:::as_list(match.call())[-1]
    args$data <- NULL
    args$specif <- NULL
    args$formula <- NULL
    args$mapping <- NULL
    args$type <- NULL
    args$auto.labs <- NULL
    args$env <- NULL
    mapping <- chart:::.rename_aes(chart:::.f_to_aes(formula, args, with.facets = TRUE))
    # Special case ~0
    if (is.numeric(mapping$x) && mapping$x == 0)
      mapping$x <- NULL
  }
  facets <- mapping$facets
  mapping$facets <- NULL
  p <- ggplot(data = data, mapping = mapping, environment = env) +
    theme()
  if (!is_null(facets)) {
    if (is_null(rlang::f_lhs(facets))) {
      p <- p + facet_wrap(facets)
    } else {
      p <- p + facet_grid(facets)
    }
  }
  if (inherits(p, "ggplot")) 
    class(p) <- unique(c("Chart", class(p)))
  p
}

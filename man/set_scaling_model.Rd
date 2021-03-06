% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/wrapper_functions.R
\name{set_scaling_model}
\alias{set_scaling_model}
\title{Sets up parameters for a scale free trait-based model}
\usage{
set_scaling_model(no_sp = 11, min_w_inf = 10, max_w_inf = 10^3,
  min_egg = 10^(-4), min_w_mat = 10^(0.4),
  no_w = log10(max_w_inf/min_egg) * 100 + 1, min_w_pp = NA,
  w_pp_cutoff = min_w_inf, n = 2/3, q = 3/4, lambda = 2 + q - n,
  r_pp = 0.1, kappa = 0.005, alpha = 0.4, ks = 4, h = 30,
  beta = 100, sigma = 1.3, f0 = 0.6, bmort_prop = 0, rfac = Inf,
  perfect = FALSE, ...)
}
\arguments{
\item{no_sp}{The number of species in the model. The default value is 11.}

\item{min_w_inf}{The asymptotic size of the smallest species in the
community. Default value is 10.}

\item{max_w_inf}{The asymptotic size of the largest species in the community.
Default value is 1000.}

\item{min_egg}{The size of the the egg of the smallest species. Default value
is 10^(-4).}

\item{min_w_mat}{The maturity size of the smallest species. Default value is
10^(0.4),}

\item{no_w}{The number of size bins in the community spectrum. Default value
is such that there are 100 bins for each factor of 10 in weight.}

\item{min_w_pp}{The smallest size of the plankton spectrum. By default this
is set to the smallest value at which any of the consumers can feed.}

\item{w_pp_cutoff}{The largest size of the plankton spectrum. Default
value is max_w_inf unless \code{perfect = TRUE} when it is Inf.}

\item{n}{Scaling of the intake. Default value is 2/3.}

\item{q}{Exponent of the search volume. Default value is 3/4 unless 
\code{lambda} is provided, in which case this argument is ignored and
q = lambda - 2 + n.}

\item{lambda}{Exponent of the abundance power law. If supplied, this 
overrules the \code{q} argument. Otherwise the default value is 2+q-n.}

\item{r_pp}{Growth rate of the primary productivity. Default value is 0.1.}

\item{kappa}{Coefficient in abundance power law. Default value is
0.005.}

\item{alpha}{The assimilation efficiency of the community. The default value
is 0.4.}

\item{ks}{Standard metabolism coefficient. Default value is 4.}

\item{h}{Maximum food intake rate. Default value is 30.}

\item{beta}{Preferred predator prey mass ratio. Default value is 100.}

\item{sigma}{Width of prey size preference. Default value is 1.3.}

\item{f0}{Expected average feeding level. Used to set \code{gamma}, the
coefficient in the search rate. The default value is 0.6.}

\item{bmort_prop}{The proportion of the total mortality that comes from
background mortality, i.e., from sources other than predation or fishing. A
number in the interval [0, 1). Default 0.}

\item{rfac}{The factor such that Rmax = rfac * R, where Rmax is the maximum
recruitment allowed and R is the steady-state recruitment. Thus the larger
\code{rfac} the less the impact of the non-linear stock-recruitment curve.
The default is Inf.}

\item{perfect}{Boolean. Default FALSE. If TRUE then parameters are set so
that the community abundance, growth before reproduction and death are
perfect power laws.}

\item{...}{Other arguments to pass to the \code{MizerParams} constructor.}
}
\value{
An object of type \code{MizerParams}
}
\description{
This functions creates a \code{MizerParams} object so that scale free
trait-based-type models can be easily set up and run. The scale free
trait-based size spectrum model can be derived as a simplification of the
general size-based model used in \code{mizer}. All the species-specific
parameters are the same for all species, except for the egg size, maturity
size and asymptotic size. These differ over the species, but the ratio of egg
size to maturity size and the ratio of egg size to asymptotic size are the
same for all species. The asymptotic sizes of the species are spread evenly
on a logarithmic scale.
}
\details{
The scale free trait-based model is similar to the standard trait-based
model, with three main differences:
\enumerate{
\item We have an exact equation for a steady state of this system which is
often stable, even when we include no extra stabilization effects like
density dependence or stock recruitment relationships.
\item The egg size is proportional to the maturity size for each species
\item The parameters are chosen so that R_0 (the expected number of offspring
produced by an individual over a lifetime) is close to 1 for each species.
}

The function has many arguments, all of which have default values. Of
particular interest to the user are the number of species in the model and
the minimum and maximum asymptotic sizes.

The characteristic weights of the different species are defined by
\code{min_egg}, \code{min_w_mat}, \code{min_w_inf}, \code{max_w_inf} and
\code{no_sp}, in the sense that the egg weights of the \code{no_sp} species
are logarithmically evenly spaced, ranging from \code{min_w = min_egg} to
\code{max_w = max_w_inf}. The maturity weights of the species can be obtained
by multiplying the egg weights by \code{min_w_mat / min_egg}. The asymptotic
weights of the species can be obtained by multiplying the egg weights by
\code{min_w_inf / min_egg}.

Although the scale free trait based model's default steady state is often
stable without imposing a stock recruitment relationship, the function can
set a Beverton-Holt type stock recruitment relationship that imposes a
maximal reproduction rate that is a multiple of the recruitment rate at
steady state. That multiple is set by the argument \code{rfac}.

In addition to setting up the parameters, this function also evaluates the
analytic expression for a steady state of the scale free trait-based model
and sets it as the initial condition.

The search rate coefficient \code{gamma} is calculated using the expected
feeding level, \code{f0}.

The option of including fishing is given, but the steady state may lose its
natural stability if too much fishing is included. In such a case the user
may wish to include stabilising effects (like \code{rfac}) to ensure the
steady state is stable. Fishing selectivity is modelled as a knife-edge
function with one parameter, \code{knife_edge_size}, which is the size at
which species are selected. Each species can either be fished by the same
gear (\code{knife_edge_size} has a length of 1) or by a different gear (the
length of \code{knife_edge_size} has the same length as the number of species
and the order of selectivity size is that of the asymptotic size).

The resulting \code{MizerParams} object can be projected forward using
\code{project()} like any other \code{MizerParams} object. When projecting
the model it may be necessary to reduce \code{dt} to 0.1 to avoid any
instabilities with the solver. You can check this by plotting the biomass or
abundance through time after the projection.
}
\examples{
\dontrun{
s_params <- set_scaling_model()
sim <- project(s_params, t_max=5, effort = 0)
plotSpectra(sim)
}
}
\seealso{
\linkS4class{MizerParams}

Other functions for setting up models: \code{\link{set_community_model}},
  \code{\link{set_multispecies_model}},
  \code{\link{set_trait_model}}
}
\concept{functions for setting up models}

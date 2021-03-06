% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/project_methods.R
\name{getFeedingLevel}
\alias{getFeedingLevel}
\title{Get feeding level}
\usage{
getFeedingLevel(object, n, n_pp, B, encounter, time_range, drop = FALSE)
}
\arguments{
\item{object}{A \code{MizerParams} or \code{MizerSim} object}

\item{n}{A matrix of species abundance (species x size). Only used if
\code{object} argument is of type \code{MizerParams}.}

\item{n_pp}{A vector of the plankton abundance by size. Only used if
\code{object} argument is of type \code{MizerParams}.}

\item{B}{A vector of biomasses of unstructured resource components}

\item{encounter}{The encounter rate matrix (optional) of dimension no.
species x no. size bins. If not passed in, it is calculated internally
using \code{\link{getEncounter}}. Only used if \code{object}
argument is of type \code{MizerParams}.}

\item{time_range}{Subset the returned fishing mortalities by time. The time
range is either a vector of values, a vector of min and max time, or a
single value. Default is the whole time range. Only used if the
\code{object} argument is of type \code{MizerSim}.}

\item{drop}{should extra dimensions of length 1 in the output be dropped,
simplifying the output. Defaults to FALSE.}
}
\value{
If a \code{MizerParams} object is passed in, the function returns a two
  dimensional array (predator species x predator size) based on the
  abundances also passed in.
  If a \code{MizerSim} object is passed in, the function returns a three
  dimensional array (time step x predator species x predator size) with the
  feeding level calculated at every time step in the simulation.
  If `drop = TRUE` then the dimension of length 1 will be removed from the
  returned array.
}
\description{
Calculates the feeding level \eqn{f_i(w)} by predator size based on food
availability, search volume and maximum intake. The feeding level is the
proportion of the encountered food that is actually consumed. It is 
defined in terms of the encounter rate \eqn{E_i} and the maximum intake 
rate \eqn{h_i(w)} as
\deqn{f_i(w) = \frac{E_i(w)}{E_i(w)+h_i(w)}}{E_i(w)/(E_i(w)+h_i(w))}
The feeding rate is used in \code{\link{getEReproAndGrowth}} and in
\code{\link{getPredRate}}.
}
\examples{
\dontrun{
data(NS_species_params_gears)
data(inter)
params <- set_multispecies_model(NS_species_params_gears, inter)
# With constant fishing effort for all gears for 20 time steps
sim <- project(params, t_max = 20, effort = 0.5)
# Get the feeding level at one time step
n <- sim@n[21,,]
n_pp <- sim@n_pp[21,]
fl <- getFeedingLevel(params,n,n_pp)
# Get the feeding level at all saved time steps
fl <- getFeedingLevel(sim)
# Get the feeding level for time 15 - 20
fl <- getFeedingLevel(sim, time_range = c(15,20))
}
}
\seealso{
\code{\link{getEncounter}}

Other rate functions: \code{\link{getEGrowth}},
  \code{\link{getEReproAndGrowth}},
  \code{\link{getERepro}}, \code{\link{getEncounter}},
  \code{\link{getFMortGear}}, \code{\link{getFMort}},
  \code{\link{getMort}}, \code{\link{getPlanktonMort}},
  \code{\link{getPredMort}}, \code{\link{getPredRate}},
  \code{\link{getRDD}}, \code{\link{getRDI}},
  \code{\link{getRates}}
}
\concept{rate functions}

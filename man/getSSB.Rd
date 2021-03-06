% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/summary_methods.R
\name{getSSB}
\alias{getSSB}
\title{Calculate the SSB of species}
\usage{
getSSB(sim)
}
\arguments{
\item{sim}{An object of class \code{MizerSim}.}
}
\value{
An array containing the SSB (time x species)
}
\description{
Calculates the spawning stock biomass (SSB) through time of the species in
the \code{MizerSim} class. SSB is calculated as the total mass of all mature
individuals.
}
\examples{
\dontrun{
data(NS_species_params_gears)
data(inter)
params <- set_multispecies_model(NS_species_params_gears, inter)
# With constant fishing effort for all gears for 20 time steps
sim <- project(params, t_max = 20, effort = 0.5)
getSSB(sim)
}
}
\seealso{
Other summary functions: \code{\link{getBiomass}},
  \code{\link{getDiet}}, \code{\link{getGrowthCurves}},
  \code{\link{getN}}, \code{\link{getYieldGear}},
  \code{\link{getYield}}
}
\concept{summary functions}
\concept{summary_function}

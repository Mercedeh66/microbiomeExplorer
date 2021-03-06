% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/feature_module.R
\name{rollDownFeatures}
\alias{rollDownFeatures}
\title{Helper function which rolls down annotated from closest higher order with 
annotation}
\usage{
rollDownFeatures(featrow)
}
\arguments{
\item{featrow}{vector of entries to be replaced where needed (fData row)}
}
\value{
modified featurerow
}
\description{
Helper function which rolls down annotated from closest higher order with 
annotation
}
\examples{
data("mouseData", package = "metagenomeSeq")
featrow <- fData(mouseData)[5,]
rollDownFeatures(featrow)

}
\author{
Janina Reeder
}

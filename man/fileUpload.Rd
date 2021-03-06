% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/data_input_module.R
\name{fileUpload}
\alias{fileUpload}
\title{Module handling file upload for the application: server}
\usage{
fileUpload(
  input,
  output,
  session,
  meData,
  meName,
  initializeData,
  addPheno,
  dataSource,
  resetFile = reactive(NULL)
)
}
\arguments{
\item{input}{module input}

\item{output}{module output}

\item{session}{app session}

\item{meData}{main reactive storing the MRexperiment data}

\item{meName}{main reactive storing the filename uploaded}

\item{initializeData}{reactiveVal keeping track of new uploads to reset data}

\item{addPheno}{reactiveVal keeping track of phenodata changes}

\item{dataSource}{reactive Value storing commands for loading data}

\item{resetFile}{indicating if module should be reset}
}
\value{
boolean denoting successful upload of a file
}
\description{
Module handling file upload for the application: server
}
\author{
Janina Reeder
}

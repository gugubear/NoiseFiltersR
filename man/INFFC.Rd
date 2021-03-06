% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/INFFC.R
\name{INFFC}
\alias{INFFC}
\alias{INFFC.default}
\alias{INFFC.formula}
\title{Iterative Noise Filter based on the Fusion of Classifiers}
\usage{
\method{INFFC}{formula}(formula, data, ...)

\method{INFFC}{default}(x, consensus = FALSE, p = 0.01, s = 3, k = 5,
  threshold = 0, classColumn = ncol(x), ...)
}
\arguments{
\item{formula}{A formula describing the classification variable and the attributes to be used.}

\item{data, x}{Data frame containing the tranining dataset to be filtered.}

\item{...}{Optional parameters to be passed to other methods.}

\item{consensus}{Logical. If FALSE, majority voting scheme is used for 'preliminary filtering' and 'noise free filtering' (see 'Details' and References' section). If TRUE, consensus
voting scheme is applied.}

\item{p}{Real number between 0 and 1. It sets the minimum proportion of original
instances which must be tagged as noisy in order to go for another iteration.}

\item{s}{Positive integer setting the stop criterion together with \code{p}. The filter stops
after \code{s} iterations with not enough noisy instances removed (according to the proportion \code{p}).}

\item{k}{Parameter for the k-nearest neighbors algorithm used for the 'noise score' stage (see 'Details' and 'References').}

\item{threshold}{Real number between -1 and 1. It sets the noise score value above which an instance is removed.}

\item{classColumn}{Positive integer indicating the column which contains the (factor of) classes.
By default, the last column is considered.}
}
\value{
An object of class \code{filter}, which is a list with seven components:
\itemize{
   \item \code{cleanData} is a data frame containing the filtered dataset.
   \item \code{remIdx} is a vector of integers indicating the indexes for
   removed instances (i.e. their row number with respect to the original data frame).
   \item \code{repIdx} is a vector of integers indicating the indexes for
   repaired/relabelled instances (i.e. their row number with respect to the original data frame).
   \item \code{repLab} is a factor containing the new labels for repaired instances.
   \item \code{parameters} is a list containing the argument values.
   \item \code{call} contains the original call to the filter.
   \item \code{extraInf} is a character that includes additional interesting
   information not covered by previous items.
}
}
\description{
Ensemble-based filter for removing label noise from a dataset as a
preprocessing step of classification. For more information, see 'Details' and
'References' sections.
}
\details{
The full description of the method can be looked up in the provided reference.
A 'preliminary filtering' is carried out with a fusion of classifiers (FC), including C4.5, 3NN, and logistic regression. Then,
potentially noisy instances are identified in a 'noise free filtering' process building the FC on the (preliminary) filtered
instances. Finally, a 'noise score' is computed on these potentially noisy instances, removing those exceeding the \code{threshold} value.
The process stops after \code{s} iterations with not enough (according to the proportion \code{p}) noisy
instances removed.
}
\note{
By means of a message, the number of noisy instances removed
in each iteration is displayed in the console.
}
\examples{
# Next example is not run because it might be time-consuming
\dontrun{
data(iris)
out <- INFFC(Species~., data = iris)
summary(out)
identical(out$cleanData, iris[setdiff(1:nrow(iris),out$remIdx),])
}
}
\references{
S\'{a}ez J. A., Galar M., Luengo J., Herrera F. (2016): INFFC: An iterative class noise filter
based on the fusion of classifiers with noise sensitivity control. \emph{Information Fusion}, 27, 19-32.
}


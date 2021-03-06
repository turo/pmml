\name{addDDAttributes}
\alias{addDDAttributes}
\title{adds attribute values to an existing DataField element in a given PMML file}
\description{

  The PMML format allows a DataField element to have various attributes which although
  useful, may not always be present in a PMML model. This function allows one to take 
  an existing PMML file and add these attributes to the DataFields.  

}
\usage{
addDDAttributes(xmlmodel=NULL,attributes=NULL,field=NULL,
                namespace="4_3",...)
}
\arguments{
  
  \item{xmlmodel}{the PMML model in a XML node format. If the model is a text file, 
    it should be converted to an XML node, for example, using the fileToXMLNode function.}
  \item{attributes}{the attributes to be added to the data fields. The user should 
    make sure that the attributes being added are allowed in the PMML schema.}
  \item{field}{The field to which the attributes are to be added. This is used when 
    the attributes are a vector of name-value pairs, intended for this one field.} 
  \item{namespace}{the namespace of the PMML model. This is frequently also the PMML 
  version the model is represented as.}
  \item{\dots}{further arguments passed to or from other methods.}

}
\details{
  The attribute information can be provided as a dataframe or a vector. Each row of the 
  data frame corresponds to an attribute name and each column corresponding to a 
  variable name. This way one can add as many attributes to as many variables as one 
  wants in one step. A more convinient method to add multiple attributes to one field 
  might be to give the attribute name and values as a vector. This function may be used 
  multiple times to add new attribute values step-by-step. However this function 
  overwrites any pre-existing attribute values, so it must be used with care. This 
  behavior is by design as this feature is meant to help an user add new defined 
  attribute values at different times. For example, one may use this to modify the display 
  name of a field at different times.

}    
\value{
  
  An object of class \code{XMLNode} as that defined by the \pkg{XML}
  package. This represents the top level, or root node, of the XML
  document and is of type PMML. It can be written to file with
  \code{saveXML}.
  
}
\author{\email{tridivesh.jena@zementis.com}}

\examples{

 # make a sample model
 library(pmml)
 model0 <- lm(Sepal.Length~., data=iris[,-5])
 model <- pmml(model0)

 # Resulting model has mining fields with no information besides
 # fieldName, dataType and optype. this object is already an xml
 # node, not an external text file; so there is no need to convert
 # it to an xml node object.

 # create data frame with attribute information

 attributes <- data.frame(c("FlowerWidth",1),c("FlowerLength",0),
                          stringAsFactors=FALSE)
 rownames(attributes) <- c("displayName","isCyclic")
 colnames(attributes) <- c("Sepal.Width","Petal.Length")
 # although not needed in this first try, necessary to easily add
 # new values later. Removes values as factors so that new values
 # added later are not evaluated as factor values and thus rejected
 # as invalid.
 attributes[] <- lapply(attributes,as.character)

 # actual command
 addDDAttributes(model,attributes,namespace="4_3")

 # Alternative method to add attributes to a single field, 
 # "Sepal.Width"
 addDDAttributes(model,c(displayName="FlowerWidth",isCyclic=1),
                "Sepal.Width")


mi<-makeIntervals(list("openClosed","closedClosed","closedOpen"),
                  list(NULL,1,2),list(1,2,NULL))
mv<-makeValues(list("A","B","C"),list(NULL,NULL,NULL),
                  list("valid",NULL,"invalid"))
addDFChildren(model, field="Sepal.Length", interval=mi, values=mv)

}
\keyword{interface}



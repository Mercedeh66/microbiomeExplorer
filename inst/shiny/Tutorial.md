---
output: 
  html_document: 
    keep_md: yes
---
# Microbiome Explorer Tutorial



## Data Preparation

### File upload

Microbiome Explorer accepts several different file formats containing metagenome sequencing results which will be stored at a MRexperiment internally. If an MRexperiment is already available, the user can simply upload it as an rdata or RDS object (the application will attempt to guess the correct file format based on the file extension). Otherwise, Biological Observation Matrix (BIOM) formattes files produced by any program including qiime2 or mothur can also be provided. Or, a simple counts matrix in csv or tsv form can be uploaded. A counts matrix should have no row names and store the information on the features/OTUs in its first columns. All other columns names should correspond to sample names.
If the data does not contain phenotype information or in case the user wants to adjust the phenotype information included with an MRexperiment or biom file, they can upload an additional phenotype file and link it with the counts data. The required format is such that each sample is a row
with the names of the rows in the phenotype data corresponding to the names of the columns in the count data. Appending several phenotype files by subsequent uploads is possible. If no phenotype file is given, the names of the columns of the count data are used as the phenotype data.
Finally, if not already included with a given MRexperiment, a feature data file must be provided if aggregation to a particular phylogenetic level is desired. Here, each unique feature is a row which must correspond to the ones in the counts data feature column and each column is a taxonomy level.
All three data entities (counts, phenotypes and features) will be stored together internally as an MRexperiment. This can be downloaded (if desired) via the "Get Data" button on the Data input page of the Microbiome Explorer.

<img src="www/img/data_input_overview.jpg" width="70%" height="70%" />


### Data Filtering

Once the data has been uploaded, several QC plots give an overview of the number of features and the number of reads available in each of the samples. Here, the user can filter sample via several sliders requiring e.g. a minimum number of features present in a sample or a minimum number of samples that a feature needs to be present in. Any changes in slider settings are immediately shown in the QC plot to allow the user to see the effect such filtering would have. In addition to threshold based filtering, the user can also decide to subset by specific phenotypes. Here, any levels that are not of interest should be selected (these will not be reflected visually in the QC plot). Once the user presses the "filter" button, the data structure is subsetted accordingly. In order to get back to the original dataset, a "reset" button is available.

<img src="www/img/data_input_filter.jpg" width="70%" height="70%" />

In addition to the basic QC plots showing distriution of number of reads and number of features, a sample based barplot gives an overview of the number of base features (e.g. OTUs) available for each sample. This can be arranged based on frequency or phenotype levels as well as colored by phenotypes via the plot options.

<img src="www/img/data_input_samplebars.jpg" width="70%" height="70%" />

All of the plots will be included in the reports if the user presses the "report" button on this page. Otherwise, filtering will be included (to reflect the data that was analyzed), but the QC plots will be omitted.

### Phenotype modifications

The phenotype tab shows the available phenotype associated with the feature count set in an interactive table. The main purpose of this table is informational, but if desired the user can create new phenotype columns by comibining existing ones. This enables the creation of new data to center the analysis around: the values of the two columns are pasted together creating an interaction value. 
The user can furthermore select columns to show in the table and remove those irrelavant for the analysis. Finally, if desired, the data type of each column can be modified by opening the adjust datatype box via clicking on the "+" icon. This is usually not required, but might be of interest for specific analysis requests. Any modifications made are only stored in the internal MRexperiment for the analysis after pressing the "save" button. All saved modifications are automatically included in the reports.

<img src="www/img/data_input_phenotype.jpg" width="70%" height="70%" />

### Feature modifications

The feature tab shows the available feature annotation associated with each raw count feature (e.g. OTU). In case of missing values which may occur for features that cannot be annotated down to a specific taxonomy level, the user has the option to either mark them as unknown (to include "unkown" as an annotation value) or to roll down the taxonomy. In this case, the highest annotated taxonomy level is reused at more specific taxonomy level with the work "unkown_" prepended. For analysis at a more specific taxonomy level, this allows summary functions to distinguish between features of higher order taxonomy levels. These changes are calculated and shown in the table after clicking the "Assign" button and can be reverted via the "reset" button. Any modifications made are only stored in the internal MRexperiment for the analysis after pressing the "save" button. All saved modifications are automatically included in the reports.

<img src="www/img/data_input_features.jpg" width="70%" height="70%" />

## Analysis

After all required modifications to the counts, phenotype or feature annotation data have been completed, the user can switch to the analysis section of the application. The analysis workflow within the application is split into five different sections: intra sample, inter sample, correlation, differential and longitudinal. Each section will be described below. Each plot is generated after the user sets all required input elements and clicks the "update" button. All visualizations are implemented using the plotly R package which provides basic interactivity, including zooming or panning via its modebar. In addition, the user can export the plot in its current state (i.e. showing specific user interactions) as a svg file using the camera icon of the modebar. 
Every analysis section includes one or more "report" buttons associated with its respective input fields. In order to include the results of the current analysis, i.e. the currently visible plots, the user can click the "report" button which will include code to reproduce the visualization outside of the application. See below for more details on reports.

### Aggregation

Before any analyses can be done, the data has to be aggregated to a specific taxonomy level. In case of a missing feature annotation, this will be limited to the raw counts data. In those cases, aggregating doesn't change the underlying counts, but still needs to be performed. For all other taxonomy levels, features are grouped by their annotation and counts are summed up for each group. 
Normalization allows for the user to account for library size differences before analysis and the user is required to make a choice on normalization methods while aggregating the data. Certain app features are restricted if none is selected (e.g. percentage is unavailable if not normalized). Differential abundance testing also requires normalization, which we perform silently if the user does not choose to do so. The two available methods available here are based on either calculating proportions or by using cumulative sum scaling (CSS), Paulson, et al. Nat Meth 2013.
If desired the user can choose to download the counts data after aggregation by clicking the "get data" button. The aggregation box will automatically close after aggregation is complete and analysis input areas will become enabled. In order to switch to a different aggregation level, the user can open the aggregation section by clicking the "+" icon associated with the box.

<img src="www/img/analysis_aggregation.jpg" width="70%" height="70%" />

### Intra Analysis

Intra-sample analysis contains functions focus on investigating the microbial composition within a sample or a group of samples. Different functions are available to visualize the relative abundance of top features, the abundance of a specific feature as well as the alpha diversity within the sample. Within the application, one common set of input elements is used to generate all visualization. 

#### Relative Abundance

Relative abundance shows the most abundant features in a barplot summarized by a user-defined variable across the x-asis. 
In addition, the user can choose to facet by phenotypes, adjust the number of features to show, switch between showing total numbers (Reads) and normalized value (if normalized), and modify the overall plot width. In general, main input elements must be defined before any visualization can be produced whereas the plot options only modify existing plots if deemed necessary.

<img src="www/img/analysis_intra_faceted.jpg" width="70%" height="70%" />

Clicking on a specific feature in the plot, automatically opens a feature abundance plot for this feature.

#### Feature abundance

The feature abundance plot shows the individual abundance of a specific feature either as a boxplot or a categorical scatterplot depending on the x-axis variable chosen. The user can choose to employ a $\text{log}_2$ scale, define plot width and decide wether to show individual sample points or not. Feature plots can be opened by selecting a specific feature in the input section or by clicking on a feature in the relative abundance plot.

<img src="www/img/analysis_intra_features.jpg" width="70%" height="70%" />


#### Alpha Diversity

Alpha diversity is a measure of the complexity or diversity within a particular sample, eg. habitat or area. Alpha diversity is computed by 
functions in the vegan package and is visualized as a boxplot using the same input definitions by feature and relative abundance. The user can choose to color and thus split the boxes by a phenotype and set the overall plot width. Multiple diversity measures are offered with Shannon diversity provided as the default. We suggest users read up on the various measures and understand the differences in interpretation and nuances. 

Shannon diversity in particular measures how evenly the microbes are distributed in a sample and is defined by the following relationship where $p_i$, is the proportion of an individual feature:
$H = -\sum_{i=1}^T p_i \ln p_i$.  
The diversity measure can be changed via the plot options and the plots can be split by a specific phenotype coloring.

<img src="www/img/analysis_intra_alpha.jpg" width="70%" height="70%" />


### Inter Analysis

Inter-sample analyses focus on differences between samples or groups of samples via feature heatmaps and beta diversity calculations. Please note that these functions can be computationally intensive if there are many samples and a low aggregation level is chosen.

### Beta Diversity

Beta diversities are the measures of the complexity of communities between samples, as compared to within a sample (alpha diversity). Calculating beta diversity first requires the computation of a pairwise distance or similarity matrix. The user can select between different measures offered via the vegan package with Bray being the suggested default selection for microbiome analysis. We suggest users read up on the various measures and understand the differences in interpretation and nuances. 

<img src="www/img/analysis_inter_beta.jpg" width="70%" height="70%" />

Principal component analysis, a dimension reduction method, is subsequently performed on the chosen distance matrix and visualized in a scatter plot. The user has the option to choose the principal components to display, add coloring and confidence ellipses based on a phenotype, define the shape based on a phenotype and adjust both the point size as well as the overall plot width.

<img src="www/img/analysis_inter_ellipses.jpg" width="50%" height="50%" />


PERMANOVA (permutational multivariate analysis of variance), from the vegan package is offered via the application (command line users will need to run this function independently and pass the results to the plotting function). Conceptually, a PERMANOVA analysis lets the user statistically determine if the centroids of a dissimilarity or distance matrix differ between groups of samples. Optionally, the user can select an phenotype as well as a strata variable with the results being shown, both within the visualization as well as in a table below it.

#### Heatmap

The heatmap offers another view on differences and similarities between the samples in a dataset. The user can either choose specific features or show the top 50 features sorted either by variance, Fano factor or median absolute deviation (MAD). The visualization is done with heatmaply which in turns relies on plotly to render the heatmap. The same options to interact with the plot are thus available. Once rendered, the user can change the number of features to include, turn of log scale, and add annotation to both rows (phenotypes) and columns (higher taxonomy levels) of the heatmap via the plot options. It is recommended to not use the heatmap functionality in datasets with many samples (5000+) as this can be quite slow to render.

<img src="www/img/analysis_inter_heatmap.jpg" width="70%" height="70%" />

### Correlation Analysis

Correlation allows the user to visualize the relationship between either two features or a feature and a numeric phenotype in a scatterplot enhanced with a linear regression statistic. Faceting and/or coloring by phenotypes is available in both correlation plots. The user is asked to choose between three different methods to aid in the evaluation of the association: Spearman (default), Pearson or Kendall.
The most common feature is selected by default as the base feature and the user has to set the correlation feature or phenotype and can opt to change the base feature. A regression line is added by default, but can be removed via the plot options.


<img src="www/img/analysis_correlation.jpg" width="70%" height="70%" />


### Differential Abundance Analysis

Differential abundance (DA) analysis is focused on testing the null hypothesis that the mean or mean ranks between groups are the same for a specific feature. DA analysis can help detect changes in feature abundance across two or more different levels of a phenotype. Four different methods can be chosen via the application: DESeq2, Kruskal-Wallis, limma, or a zero-inflated log normal model. DESeq2 and limma are widely used methods for comparisons in microarray and RNA-sequencing data which can easily be adapted for microbiome data. Kruskal-Wallis is a non-parametric test for any differences in distribution between groups. The zero-inflated log normal model is implemented in the metagenomeSeq package to account for zero-inflation in microbiome data. Typically, DESeq2 would is used with small (<=25) sample sizes. The results will be displayed in an interactive table (DT) within the application and the user can open feature plots showing the specific levels by clicking on a row of interest.

<img src="www/img/analysis_differential.jpg" width="70%" height="70%" />
<img src="www/img/analysis_diff_details.jpg" width="70%" height="70%" />

### Longitudinal Analysis

Longitudinal analysis allows the user to generate feature plots with more control over the data shown within the plot. For a specific feature, the user can choose a phenotype and specific levels of that phenotype to show in the plot. The chosen order of the levels will be kept within the visualization which allows sorting by specific dates or tissues among other things. All of these input elements are required to produce a visualization. In addtion, if desired and available, the user can choose a specific phenotype to summarize on which will then be connected by lines across the different levels. The resulting visualization is interactive and the user can then select and color specific IDs within the plot by clicking on the lines or selecting them via the input element above the plot. Several different IDs can be selected using different colors via the color select element next to the input element. In order to do this via mouse clicks on the plot, the user has to hold the shift key when adding additional line selections.

<img src="www/img/analysis_longitudinal.jpg" width="70%" height="70%" />

## Reports

Once an analysis is complete, a user might like to share the results with collaborators or download them for further analysis beyond the functionality provided via the Microbiome Explorer. To do this, we are providing the option to include any part of the analysis in a report which is fully reproducible outside of the application.

### Report Settings

In the report settings, the user can choose file name and add a project title, authors as well as any other text to be included in the output. Four different output formats are available by default. Please note that report generation does rely on the availability of external programs such as pandoc and latex (pdf). The available output formats can be restricted in global.R.

In addition to the basic settings, the user can also review any analysis made and choose which parts should be included in the report and which shouldn't. For each analysis element, the relevant R code is shown next to an icon illustrating the type of analysis. This is intended to help users without a computational background to identify which section is related to which part of their analysis. Those steps that are essential such as data loading or aggregation cannot be deselected.

<img src="www/img/reports.jpg" width="70%" height="70%" />

## Report Generation

In order to obtain the report, the user first clicks the "Generate" button. Then, the relevant R code collected during the analysis anytime the user clicks the "Report" button is written to a temporary file. The temporary R file is then knitted into an Rmd document using knitr::spin and subsequently rendered to the desired output format(s) with rmarkdown::render. R code chunks are enhanced with basic parameters to optimize the sizing of figures. This works reasonably well for HTML output. In order to produce well-designed output in other formats, more editing of the Rmarkdown document is recommended.

During the process any analysis is repeated for each output format while calling the render function. In future versions of the application, we are planning to do this as a background process with the results emailed to users. For now, the user needs to patiently wait until the render process has completed and then download the results by clicking "EXPORT". They will then obtain a zip folder which holds both the Rmd document as well as any output formats specified. The Rmd document can be edited and re-rendered outside of the application. The only modification required is to adjust the path to the input data which is unknown to the application.


<img src="www/img/report_output.jpg" width="70%" height="70%" />

## Offline use of the R package

All functionality available via the application is also accessible via the command line in a standard R environment. Please refer to package documentation and vignette for information on how to do this.

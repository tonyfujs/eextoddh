#' format_md_metadata
#'
#' Format specific variable to fit Microdata or DDH requirements
#'
#' @param metadata_in list: flattened list of metadata
#'
#' @return list
#' @export
#'

format_md_metadata <- function(metadata_in,
                               date_fields = c("field_wbddh_modified_date",
                                               "field_wbddh_release_date"),
                               text_fields = c("body",
                                               "field_wbddh_citation_text",
                                               "field_wbddh_disclaimer",
                                               "field_wbddh_questionnaires",
                                               "field_wbddh_sampling_procedure",
                                               "field_wbddh_series_information",
                                               "field_wbddh_supervision")) {

  # Format title
  metadata_in[['title']] <- paste(metadata_in[['field_wbddh_country']], metadata_in[['title']], sep = ' - ')

  # Format date fields
  metadata_in[date_fields] <- purrr::map(metadata_in[date_fields], timestamp_to_ddhdate)

  # Format text fields
  metadata_in[text_fields] <- purrr::map(metadata_in[text_fields], format_text)

  return(metadata_in)
}

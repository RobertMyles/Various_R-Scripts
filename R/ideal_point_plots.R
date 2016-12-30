# create a plot out of mcmc ideal point analysis data. 'rc' should be the list returned from the rollcallmatrix function stored on this repo, or a similar list that contains a dataframe called "Legis_data". 

ideal_plot <- function(mcmc, Legis = FALSE, Party = FALSE, rc = NULL){
  
  Theta <- as.data.frame(mcmc$statistics[grep("theta", 
                                              row.names(mcmc$statistics)),
                                           1])
  colnames(Theta) <- "mean"
  ThetaQ <- mcmc$quantiles[grep("theta", 
                                  row.names(mcmc$statistics)),
                             c(1,5)]
  
  if(Legis == TRUE & is.null(rc)){
    
    return(message("Error: rollcall list not found."))
    
  } else if(Legis == FALSE & Party == TRUE){
    
    return(message("Cannot use 'party' when 'Legis' is FALSE."))
    
  }
  else if(Legis == TRUE & !is.null(rc) & Party == FALSE){
    
    x <- rc$Legis_data
    theta <- data_frame(
      mean = Theta$mean,
      lower = ThetaQ[, 1], 
      upper = ThetaQ[, 2],
      Legislator = row.names(Theta)) %>% 
      arrange(mean) %>% 
      mutate(Legislator = as.integer(gsub("theta\\.", "", Legislator))
      )
    theta <- suppressMessages(full_join(theta, x))
    Y <- seq(1, length(theta$mean), by = 1)
    
    g_1 <- ggplot(theta, aes(x = mean, y = Y, colour = GovCoalition)) + 
          geom_point(shape = 19, size = 3) + 
          geom_errorbarh(aes(xmin = lower, xmax = upper), height = 0) + 
          geom_text(aes(x = upper, label = Legislator), size = 2.5, 
                    hjust = -.05) + 
          scale_colour_manual(values = c("red", "blue")) + 
          theme(axis.text.y = element_blank(), 
                axis.ticks.y = element_blank(), 
                axis.title = element_blank(), 
                legend.position = c(.08, .8), 
                panel.grid.major.y = element_blank(), 
                panel.grid.major.x = element_line(linetype = 1, 
                                                  colour = "grey"), 
                panel.grid.minor = element_blank(), 
                panel.background = element_rect(fill = "white"), 
                panel.border = element_rect(colour = "black", fill = NA, 
                                            size = .4)) + 
          scale_x_continuous(limits = c(min(theta$mean) - 1.5, 
                                        max(theta$mean) + 1.5))
    return(g_1)
  } else if(Party == TRUE){
    x <- rc$Legis_data
    theta <- data_frame(
      mean = Theta$mean,
      lower = ThetaQ[, 1], 
      upper = ThetaQ[, 2],
      Legislator = row.names(Theta)) %>% 
      arrange(mean) %>% 
      mutate(Legislator = as.integer(gsub("theta\\.", "", Legislator))
      )
    theta <- suppressMessages(full_join(theta, x))
    Y <- seq(1, length(theta$mean), by = 1)
    
    g_2 <- ggplot(theta, aes(x = mean, y = Y, colour = Party)) + 
      geom_point(shape = 19, size = 3) + 
      geom_errorbarh(aes(xmin = lower, xmax = upper), height = 0) + 
      geom_text(aes(x = upper, label = Legislator), size = 2.5, 
                hjust = -.05) + 
      theme(axis.text.y = element_blank(), 
            axis.ticks.y = element_blank(), 
            axis.title = element_blank(), 
            legend.position = c(.08, .63), 
            panel.grid.major.y = element_blank(), 
            panel.grid.major.x = element_line(linetype = 1, 
                                              colour = "grey"), 
            panel.grid.minor = element_blank(), 
            panel.background = element_rect(fill = "white"), 
            panel.border = element_rect(colour = "black", fill = NA, 
                                        size = .4)) + 
      scale_x_continuous(limits = c(min(theta$mean) - 1.5, 
                                    max(theta$mean) + 1.5))
    return(g_2)
  } else{
    
    theta <- data_frame(
      mean = Theta$mean,
      lower = ThetaQ[, 1], 
      upper = ThetaQ[, 2],
      Legislator = row.names(Theta)) %>% 
      arrange(mean) %>% 
      mutate(Legislator = as.integer(gsub("theta\\.", "", Legislator))
      )

    Y <- seq(1, length(theta$mean), by = 1)
    
    g_3 <- ggplot(theta, aes(x = mean, y = Y)) + 
      geom_point(shape = 19, size = 3) + 
      geom_errorbarh(aes(xmin = lower, xmax = upper), height = 0) + 
      geom_text(aes(x = upper, label = Legislator), size = 2.5, 
                hjust = -.05) + 
      theme(axis.text.y = element_blank(), 
            axis.ticks.y = element_blank(), 
            axis.title = element_blank(), 
            legend.position = c(.08, .63), 
            panel.grid.major.y = element_blank(), 
            panel.grid.major.x = element_line(linetype = 1, 
                                              colour = "grey"), 
            panel.grid.minor = element_blank(), 
            panel.background = element_rect(fill = "white"), 
            panel.border = element_rect(colour = "black", fill = NA, 
                                        size = .4)) + 
      scale_x_continuous(limits = c(min(theta$mean) - 1.5, 
                                    max(theta$mean) + 1.5))
    return(g_3)
  }
  
}

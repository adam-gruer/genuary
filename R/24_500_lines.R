library(ggplot2)
library(magrittr)
library(gganimate)


lines_data <- data.frame(
  x  = runif(500, 0,1),
  y = rbeta(500, 2, 3),
  xend = rnorm(500, 0.5, 500),
  yend = rnorm(500, 12, 500),
  color  = colors(distinct = TRUE) %>% 
            sample( size = 32) %>% 
            sample(size = 500, replace = TRUE),
  group = sample(1:25, 500, replace = TRUE),
  alpha = sample(c(0.4, 0.5, 0.60, 0.8), 500, replace = TRUE)
)

 
p <- ggplot() +
  theme_void() +
  theme(plot.background = element_rect(fill=rgb(0.1,0,0,0.94))) +
  geom_segment(mapping = aes(x =x,
                             y = y,
                             xend = xend,
                             yend = yend ,
                             color = color,
                             group = group,
                             alpha = alpha),
               data = lines_data,
               show.legend = FALSE
               ) +
  coord_polar(start = 20,-1, theta = "x")

p

anim_rev_x <- p +
  transition_reveal(x) +
  ease_aes ( y = "elastic-in-out")  +
  enter_fade() +
  shadow_wake(wake_length = .2,
              falloff = "quintic-in")
              
animate(a, type = "cairo", fps = 20, nframes = 150)

anim_save("inst/ext/genuary24.gif")

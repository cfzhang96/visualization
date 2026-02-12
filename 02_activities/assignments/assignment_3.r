library(tidyverse)
library(ggplot2)
library(dplyr)
# Load dataset
df <- read.csv("./Desktop/visualization/02_activities/assignments/TTC LRT Delays.csv")

# Define correct weekday order
day_order <- c(
  "Monday", "Tuesday", "Wednesday",
  "Thursday", "Friday", "Saturday", "Sunday"
)

# Convert to ordered factor
df$Day <- factor(df$Day, levels = day_order)

# Calculate average delay by day
day_delay <- df %>%
  group_by(Day) %>%
  summarise(avg_delay = mean(`Min.Delay`, na.rm = TRUE))

# Create plot
p1 <- ggplot(day_delay, aes(Day, avg_delay, group = 1)) +
  geom_line(linewidth = 1.2, color = "#1F2D3D") +
  geom_point(size = 3.2, color = "#E74C3C") +
  geom_text(aes(label = sprintf("%.1f", avg_delay)),
            vjust = -0.8, size = 3.3, color = "#1F2D3D") +
  labs(
    title = "Average LRT Delay by Day of Week",
    subtitle = "Mean of reported minimum delay (minutes)",
    x = NULL,
    y = "Average delay (min)"
  ) +
  theme_minimal(base_size = 12) +
  theme(
    panel.grid.minor = element_blank(),
    panel.grid.major.x = element_blank(),
    plot.title = element_text(face = "bold"),
    axis.text.x = element_text(face = "bold"),
    plot.margin = margin(8, 12, 8, 12)
  )

print(p1)

ggsave("avg_lrt_delay_by_day.png", p1, width = 8, height = 4.5, dpi = 300)


> What software did you use to create your data visualization?

R using the ggplot2 package from the tidyverse ecosystem.

> Who is your intended audience?

The intended audience includes:

TTC riders and daily commuters

City transportation planners

Transit operations analysts

Policy makers concerned with public transit reliability

> What information or message are you trying to convey with your visualization?

This visualization shows how the average LRT delay varies across the days of the week.

It highlights temporal patterns in service reliability and allows viewers to identify whether certain weekdays experience consistently higher delays compared to others.

The goal is to reveal whether delays follow a weekly structure rather than occurring randomly.

> What aspects of design did you consider when making your visualization? How did you apply them? With what elements of your plots?

Chart type: A line chart was selected because days of the week represent an ordered temporal sequence. ggplot’s geom_line() emphasizes continuity across time.

Ordering: The Day variable was explicitly converted to an ordered factor to ensure the plot reflects the natural Monday–Sunday sequence.

Minimalism: The theme_minimal() theme was used to remove unnecessary gridlines and visual clutter.

Contrast: A dark line with contrasting red markers was used to ensure the data points remain visually distinct.

Markers: geom_point() was added to make each average clearly visible.

> How did you ensure that your data visualizations are reproducible?

The dataset is publicly available from the City of Toronto Open Data Portal.

All data cleaning, aggregation, and visualization steps are written in an R script.

The analysis uses tidyverse pipelines, ensuring transparency in transformation steps.

Any user with the dataset and the script can reproduce identical results.

If a tool that does not retain code (e.g., manual Excel plotting) were used, reproducibility would be limited because transformation steps would not be explicitly documented.

> How did you ensure that your data visualization is accessible?

Clear and descriptive axis labels and title.

High-contrast colors that do not rely on color interpretation alone.

Simple design without excessive decoration.

Readable base font size.

The visualization can be interpreted even in grayscale (line and markers differentiate data).

> Who are the individuals and communities who might be impacted by your visualization?

Daily commuters relying on TTC LRT service.

Shift workers whose arrival times are critical.

Employers and businesses affected by transit delays.

Transit planning departments adjusting schedules and staffing.

Communities dependent on reliable public transportation infrastructure.

> How did you choose which features of your chosen dataset to include or exclude from your visualization?

Included:

Day (temporal variable)

Min Delay (measure of service disruption)

Excluded:

Station-level data

Vehicle-level identifiers

Incident descriptions

These were excluded to focus specifically on system-wide temporal patterns, rather than spatial or operational details.

> What ‘underwater labour’ contributed to your final data visualization product?

Cleaning and validating categorical day-of-week entries.

Reordering the factor levels to match real-world weekday order.

Handling missing values (na.rm = TRUE).

Checking for outliers that might distort averages.

Verifying consistency in delay measurement units.

Reviewing design choices for clarity and accessibility.
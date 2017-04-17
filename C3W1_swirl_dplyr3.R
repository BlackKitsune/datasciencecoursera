#### C3W1 - Swirl practice

# Clean the list of variables in your workspace
rm(list = ls())

# Begin 
library(swirl)
swirl()

# 3: Tidying Data with tidyr

library(tidyr)

# Tidy data is formatted in a standard way that facilitates exploration
# and analysis and works seamlessly with other tidy data tools.
# Specifically, tidy data satisfies three conditions: 
        # 1) Each variable forms a column
        # 2) Each observation forms a row
        # 3) Each type of observational unit forms a table

# Example1: Students grades.
# > students
#   grade male female
# 1     A    1      5
# 2     B    5      0
# 3     C    5      2
# 4     D    5      5
# 5     E    7      4

# This datase actually has 3 variables: grades, sex, and count.
# Gather data to represents exactly one observation
?gather
gather(students, sex, count, -grade)

# Example2: Students grades with 2 classes.
# > students2
#   grade male_1 female_1 male_2 female_2
# 1     A      3        4      3        4
# 2     B      6        4      3        5
# 3     C      7        4      3        8
# 4     D      4        0      8        1
# 5     E      1        1      2        7

# Now there is 2 separate classes (1,2) for each sex within each class.
# We need (grade, sex, class and count) using gather 
# Use as a key column sex_class and the value column count
res <- gather(students2, sex_class, count, -grade)
res

# Now use separate() to separeate the sex_class column
?separate
separate(data = res, col = sex_class, into = c("sex", "class"))

### Do the same steps but chaining
# Repeat your calls to gather() and separate(), but this time
# use the %>% operator to chain the commands together without
# storing an intermediate result.
#
# If this is your first time seeing the %>% operator, check
# out ?chain, which will bring up the relevant documentation.
# You can also look at the Examples section at the bottom
# of ?gather and ?separate.
#
# The main idea is that the result to the left of %>%
# takes the place of the first argument of the function to
# the right. Therefore, you OMIT THE FIRST ARGUMENT to each
# function.
#
students2 %>%
        gather(sex_class, count, -grade) %>%
        separate( sex_class, c("sex", "class")) %>%
        print

### Example3: Students grades 3 variables stored in columns and rows
# > students3
#     name    test class1 class2 class3 class4 class5
# 1  Sally midterm      A   <NA>      B   <NA>   <NA>
# 2  Sally   final      C   <NA>      C   <NA>   <NA>
# 3   Jeff midterm   <NA>      D   <NA>      A   <NA>
# 4   Jeff   final   <NA>      E   <NA>      C   <NA>
# 5  Roger midterm   <NA>      C   <NA>   <NA>      B
# 6  Roger   final   <NA>      A   <NA>   <NA>      A
# 7  Karen midterm   <NA>   <NA>      C      A   <NA>
# 8  Karen   final   <NA>   <NA>      C      A   <NA>
# 9  Brian midterm      B   <NA>   <NA>   <NA>      A
# 10 Brian   final      B   <NA>   <NA>   <NA>      C

# Midterm and final are variables, and one class variable and grades
# Call gather() to gather the columns class1
# through class5 into a new variable called class.
# The 'key' should be class, and the 'value'
# should be grade.
#
# tidyr makes it easy to reference multiple adjacent
# columns with class1:class5, just like with sequences
# of numbers.
#
# Since each student is only enrolled in two of
# the five possible classes, there are lots of missing
# values (i.e. NAs). Use the argument na.rm = TRUE
# to omit these values from the final result.
#
# Remember that when you're using the %>% operator,
# the value to the left of it gets inserted as the
# first argument to the function on the right.
#
# Consult ?gather and/or ?chain if you get stuck.
#
students3 %>%
        gather(class, grade ,class1 : class5 , na.rm = TRUE) %>%
        print


# Use spread() to separate de name and tes into the corresponding columns
# This script builds on the previous one by appending
# a call to spread(), which will allow us to turn the
# values of the test column, midterm and final, into
# column headers (i.e. variables).
#
# You only need to specify two arguments to spread().
# Can you figure out what they are? (Hint: You don't
# have to specify the data argument since we're using
# the %>% operator.
#
students3 %>%
        gather(class, grade, class1:class5, na.rm = TRUE) %>%
        spread(test, grade) %>%
        print

# Use the readr package to change the class column a num with parse_number()
library(readr)
parse_number("class5")

# We want the values in the class columns to be
# 1, 2, ..., 5 and not class1, class2, ..., class5.
#
# Use the mutate() function from dplyr along with
# parse_number(). Hint: You can "overwrite" a column
# with mutate() by assigning a new value to the existing
# column instead of creating a new column.
#
# Check out ?mutate and/or ?parse_number if you need
# a refresher.
#
students3 %>%
        gather(class, grade, class1:class5, na.rm = TRUE) %>%
        spread(test, grade) %>%
        mutate(class = parse_number(class)) %>%
        print


### Example4: Multiple observational units stored in the same table.
# > students4
#     id  name sex class midterm final
# 1  168 Brian   F     1       B     B
# 2  168 Brian   F     5       A     C
# 3  588 Sally   M     1       A     C
# 4  588 Sally   M     3       B     C
# 5  710  Jeff   M     2       D     E
# 6  710  Jeff   M     4       A     C
# 7  731 Roger   F     2       C     A
# 8  731 Roger   F     5       B     A
# 9  908 Karen   M     3       C     C
# 10 908 Karen   M     4       A     A

# At first glance, there doesn't seem to be much of a problem with
# students4. All columns are variables and all rows are observations.
# However, notice that each id, name, and sex is repeated twice, which
# seems quite redundant. This is a hint that our data contains multiple
# observational units in a single table

# Our solution will be to break students4 into two separate tables -- one
# containing basic student information (id, name, and sex) and the other
# containing grades (id, class, midterm, final).
# Edit the R script, save it, then type submit() when you are ready. Type
# reset() to reset the script to its original state.

# Complete the chained command below so that we are
# selecting the id, name, and sex column from students4
# and storing the result in student_info.
#
student_info <- students4 %>%
        select(id, name, sex) %>%
        print

# Add a call to unique() below, which will remove
# duplicate rows from student_info.
#
# Like with the call to the print() function below,
# you can omit the parentheses after the function name.
# This is a nice feature of %>% that applies when
# there are no additional arguments to specify.
#
student_info <- students4 %>%
        select(id, name, sex) %>%
        unique() %>%
        print

# select() the id, class, midterm, and final columns
# (in that order) and store the result in gradebook.
#
gradebook <- students4 %>%
        select(id,class,midterm,final) %>%
        print

# student_info and gradebook the id column that is primary key to conect them


### Example5: A single observational unit stored in multiple tables.
# > passed
#    name class final
# 1 Brian     1     B
# 2 Roger     2     A
# 3 Roger     5     A
# 4 Karen     4     A

# > failed
#    name class final
# 1 Brian     5     C
# 2 Sally     1     C
# 3 Sally     3     C
# 4  Jeff     2     E
# 5  Jeff     4     C
# 6 Karen     3     C

# Create a new column in passed with "passed" status and "failed" for failed
passed <- passed %>% mutate(status = "passed")
failed <- failed %>% mutate(status = "failed")

# bind_rows() join the tables together into a single unit
# only available in dplyr > 0.4.0
?bind_rows
packageVersion('dplyr')
bind_rows(passed,failed)


# Example6: Tidy a real dataset from the SAT college exam
# The SAT is a popular college-readiness exam in the United States that
# consists of three sections: critical reading, mathematics, and writing.
# Students can earn up to 800 points on each section. This dataset
# presents the total number of students, for each combination of exam
# section and sex, within each of six score ranges. It comes from the
# 'Total Group Report 2013', which can be found here:
# http://research.collegeboard.org/programs/sat/data/cb-seniors-2013

# > sat
# A tibble: 6 × 10
# score_range read_male read_fem read_total math_male math_fem math_total
#    <chr>     <int>    <int>      <int>     <int>    <int>      <int>
# 1  700-800     40151    38898      79049     74461    46040     120501
# 2  600-690    121950   126084     248034    162564   133954     296518
# 3  500-590    227141   259553     486694    233141   257678     490819
# 4  400-490    242554   296793     539347    204670   288696     493366
# 5  300-390    113568   133473     247041     82468   131025     213493
# 6  200-290     30728    29154      59882     18788    26562      45350
# ... with 3 more variables: write_male <int>, write_fem <int>,
#   write_total <int>

# Accomplish the following three goals:
#
# 1. select() all columns that do NOT contain the word "total",
# since if we have the male and female data, we can always
# recreate the total count in a separate column, if we want it.
# Hint: Use the contains() function, which you'll
# find detailed in 'Special functions' section of ?select.
#
# 2. gather() all columns EXCEPT score_range, using
# key = part_sex and value = count.
#
# 3. separate() part_sex into two separate variables (columns),
# called "part" and "sex", respectively. You may need to check
# the 'Examples' section of ?separate to remember how the 'into'
# argument should be phrased.
#
sat %>%
        select(-contains("total")) %>%
        gather(part_sex, count, -score_range) %>%
        separate(part_sex, c("part","sex")) %>%
        print

# Append two more function calls to accomplish the following:
#
# 1. Use group_by() (from dplyr) to group the data by part and
# sex, in that order.
#
# 2. Use mutate to add two new columns, whose values will be
# automatically computed group-by-group:
#
#   * total = sum(count)
#   * prop = count / total
#
sat %>%
        select(-contains("total")) %>%
        gather(part_sex, count, -score_range) %>%
        separate(part_sex, c("part", "sex")) %>%
        group_by(part,sex) %>%
        mutate(total = sum(count),
               prop = count / total
        ) %>% print
        

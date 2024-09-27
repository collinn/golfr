---
title: "Iteratively Assigning Students into Groups with Arbitrary Constraints"
author: "Collin Nolte, Hannah Kim"
date: "2024-07-03"
output: pdf_document
---

# Abstract

This research focuses on developing an R package that automates student group assignments, drawing inspiration from the social golfer problem (SGP), a combinatorial challenge that avoids repeated pairings across multiple rounds. The goal is to create an efficient tool for educators that simplifies the group formation process while considering various constraints, enhancing collaborative learning. By leveraging SGP principles, the project aims to streamline group assignments in larger classes, making the process more systematic and flexible.
# 1 sentence of results can be added


# Introduction
## Objective

The effective management of student group assignments is a critical component of
contemporary educational practice, particularly in courses where collaboration
enhances the learning experience.
This project addresses the development of an R package designed to automate the
iterative assignment of students into groups, with specific emphasis on optimizing
group dynamics and ensuring fair participation.
Our primary research objective is to create a tool that simplifies and streamlines
the process of forming student groups.

## Motivation

The motivation for this project stems from the observation that many faculty
members find it easier to teach class material and facilitate student learning
through group activities rather than individual assignments.
Group work fosters collaboration, critical thinking, and peer learning,
making it an essential pedagogical strategy.
However, the manual process of assigning students to groups can be cumbersome
and inefficient, particularly as class sizes increase.
An automated solution not only saves time but also ensures that groups are formed
systematically, considering various constraints and preferences.

## Social Golfer Problem (SGP)
The program is closely related to the social golfer problem, a well-known combinatorial
problem in mathematics and computer science. [1]
The social golfer problem asks how a given number of golfers can be arranged into
groups of a specific size over multiple rounds, such that no golfer is grouped
with the same golfer more than once. [1]
Solving this problem presents significant challenges due to the complexity of
ensuring that all constraints are met while optimizing for minimal repetition of 
groupings. 

## Previous Researches

We wrote the pseudocode based on `good-enough-golfers` by Buchanan, B (2017), 
a java script program designed to nearly solve the social golfer problem, 
specifically one of the main functions called `genericsolver`.
While writing, we faced several challenges, especially since it was our first attempt.
Translating our understanding into clear, step-by-step pseudocode was difficult. 
We found it challenging to abstract the code's logic into plain language, 
especially when some of us do not have any previous experience or knowledge in java script.
Striking the right balance between detail and simplicity was also tricky; 
too much detail risked overcomplicating the pseudocode, while too little could make it vague. 
If we had another opportunity, we would focus more on breaking down complex sections into smaller, 
more manageable parts before converting it to more detailed pseudocode.
This approach would help us ensure that each step is comprehensible and logically connected.

Our project draws inspiration from the same problem, aiming to develop a practical tool
that can be used by educators to manage student group assignments effectively.
By leveraging the principles underlying the social golfer problem, we seek to create
a robust and flexible package that accommodates various grouping requirements and
enhances the overall educational experience. 

# Methods








# Results









# Discussion





# Conclusion

This research addresses the complex issue of managing student group assignments
in educational settings by developing an R package that automates the iterative
assignment of students into groups.
By leveraging the principles of social golfer problem, we aimed to create a tool
that simplifies the group assignment process, thus enhancing collaboration, 
critical thinking, and peer learning among students.

Despite the promising outcomes, there are several limitations and constraints
inherent to solving the social golfer problem, which also affect our approach.
Firstly, the problem's combinatorial nature makes it computationally intensive,
particularly as the number of students and the number of iterations increase.
This complexity can lead to significant processing times and may require high computational resources,
which could limit the tool's applicability in larger classes or more extensive iterations. 
Moreover, the solution's optimality is not guaranteed in all scenarios;
certain configurations may still result in some repetition of group members,
particularly when the number of students or the group sizes do not neatly fit the required criteria.

Another constraint is the potential lack of scalability and flexibility in
dealing with various educational contexts and settings.
While our tool is designed to be robust and adaptable, it may face challenges
when applied to courses with highly diverse or specialized requirements.
For instance, classes with students who have vastly different skill levels, interests,
or learning objectives may require more sophisticated algorithms to ensure balanced
and effective group assignments.
Additionally, certain courses may necessitate frequent reconfiguration of groups
based on ongoing assessments or evolving class dynamics, which could be challenging
to implement efficiently within the current framework.

Future research could focus on enhancing the flexibility and adaptability of the
group assignment tool.
One potential direction is the incorporation of machine learning algorithms that
learn from past group assignments to predict and optimize future group configurations.
Additionally, integrating real-time feedback mechanisms could allow the tool to
adjust group assignments dynamically based on student performance and interactions.
Exploring hybrid approaches that combine automated group assignments with manual
adjustments made by instructors could also provide a balanced solution, improving
computational efficiency while maintaining human oversight.

# References
[1] Wikimedia Foundation. (2024, January 30). Social golfer problem. Wikipedia. https://en.wikipedia.org/wiki/Social_golfer_problem 

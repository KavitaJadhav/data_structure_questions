# https://leetcode.com/problems/course-schedule/description/
# https://www.youtube.com/watch?v=EgI5nU9etnU
# https://www.youtube.com/watch?v=Oa4Srx9mDqs
#
# There are a total of numCourses courses you have to take, labeled from 0 to numCourses - 1. You are given an array prerequisites where prerequisites[i] = [ai, bi] indicates that you must take course bi first if you want to take course ai.
#
# For example, the pair [0, 1], indicates that to take course 0 you have to first take course 1.
# Return true if you can finish all courses. Otherwise, return false.
#
# Example 1:
# Input: numCourses = 2, prerequisites = [[1,0]]
# Output: true
# Explanation: There are a total of 2 courses to take.
# To take course 1 you should have finished course 0. So it is possible.

# Example 2:
# Input: numCourses = 2, prerequisites = [[1,0],[0,1]]
# Output: false
# Explanation: There are a total of 2 courses to take.
# To take course 1 you should have finished course 0, and to take course 0 you should also have finished course 1. So it is impossible.
#

# Approach - create a dependency map of course, go through each course and check if dependency can be completed
# create a map of default dependencies
# update map to add all dependencies from input
# for all courses check in loop if it can be finished

# Complexity
# Space - O(N + M)
# Time -  O(N + M) - n- course count, m. course dependencies
#
# “This solution runs in linear time O(V + E) using DFS cycle detection, with linear space for the graph, visited sets, and recursion stack.”
#
# Space Complexity
#
# O(V + E)
#
# Breakdown:
#
# course_dependencies hash → O(V + E)
#
# visted_courses set → O(V)
#
# visiting_courses set → O(V)
#
# Recursion stack (worst case chain) → O(V)
#
# ⏱ Time Complexity
#
# O(V + E)
#
# Where:
#
# V = count (number of courses)
#
# E = courses.length (number of prerequisite pairs)
#
# Why?
#
# Each course is added to visted_courses once
#
# Each dependency (edge) is traversed once
#
# DFS never reprocesses a completed node
#
# So total work = all nodes + all edges.
require 'byebug'
require 'set'

def can_be_completed?(course, course_dependencies, visted_courses, visiting_courses)
  return true if visted_courses.include?(course)
  return false if visiting_courses.include?(course)

  visiting_courses.add(course)

  course_dependencies[course].each do |dependency|
    return false unless can_be_completed?(
        dependency,
        course_dependencies,
        visted_courses,
        visiting_courses
    )
  end

  visiting_courses.delete(course)
  visted_courses.add(course)

  true
end

def can_finish(courses, count)
  course_dependencies = Hash.new {|h, k| h[k] = []}

  count.times do |index|
    course_dependencies[index] = []
  end

  courses.each do |course|
    course_dependencies[course[0]] << course[1]
  end

  visted_courses = Set.new
  visiting_courses = Set.new

  # Important: check ALL courses, not just those in prerequisites
  (0...count).each do |course|
    return false unless can_be_completed?(
        course,
        course_dependencies,
        visted_courses,
        visiting_courses
    )
  end

  true
end


puts can_finish([[1, 0]], 2) == true
puts can_finish([[1, 0], [0, 1]], 2) == false

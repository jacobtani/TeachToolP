# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Subject.create(subject_name: 'Mathematics', fee: '98.00', lowest_grade_taught: '1', highest_grade_taught: '7')
Subject.create(subject_name: 'English', fee: '98.00', lowest_grade_taught: '1', highest_grade_taught: '7')
Pack.create(name: '5++', description: 'A pack for advanced fifth graders', action_required: 'Nothing', subject_id: 1)
Pack.create(name: '5--', description: 'A pack for less competent fifth graders', action_required: 'Nothing', subject_id: 1)
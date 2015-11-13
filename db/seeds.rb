Subject.create(subject_name: 'Mathematics', fee: '98.00', lowest_grade_taught: '1', highest_grade_taught: '7')
Subject.create(subject_name: 'English', fee: '98.00', lowest_grade_taught: '1', highest_grade_taught: '7')
Pack.create(name: '5++', description: 'A pack for advanced fifth graders', action_required: 'Nothing', subject_id: 1)
Pack.create(name: '5--', description: 'A pack for less competent fifth graders', action_required: 'Nothing', subject_id: 1)
User.create(first_name: 'Employer', surname: 'User', role: 'employer', postal_address: 'some address', email: 'employer@gmail.com', password: 'tania551')
User.create(first_name: 'Admin', surname: 'User', role: 'admin', postal_address: 'some address', email: 'admin@gmail.com', password: 'tania551')
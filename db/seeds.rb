@maths = Subject.create(subject_name: 'Mathematics', fee: '98.00', lowest_grade_taught: '1', highest_grade_taught: '7')
@english = Subject.create(subject_name: 'English', fee: '98.00', lowest_grade_taught: '1', highest_grade_taught: '7')
Pack.create(name: '5++', description: 'A pack for advanced fifth graders', action_required: 'Nothing', subject_id: @maths.id)
Pack.create(name: '5--', description: 'A pack for less competent fifth graders', action_required: 'Nothing', subject_id: @maths.id)
User.create(first_name: 'Employee', surname: 'User', role: 'employee', postal_address: 'some address', email: 'employee@gmail.com', password: 'tania551')
User.create(first_name: 'Admin', surname: 'User', role: 'admin', postal_address: 'some address', email: 'admin@gmail.com', password: 'tania551')
Fee.create(start_date: Date.today , end_date: Date.today + 1.year , amount: 100, fee_type: 0)
Fee.create(start_date: Date.today , end_date: Date.today + 1.year , amount: 160, fee_type: 1, subject_id: @maths.id)
Fee.create(start_date: Date.today , end_date: Date.today + 1.year , amount: 160, fee_type: 1, subject_id: @english.id)
Offer.create(offer_name: 'Premier Group X English', offer_description: 'Starting English Offer', start_date: Date.today , end_date: Date.today + 1.year, subject_id: @english.id)
Offer.create(offer_name: 'Premier Group X Mathematics', offer_description: 'Starting Maths Offer', start_date: Date.today , end_date: Date.today + 1.year, subject_id: @maths.id)
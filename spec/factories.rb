SUNDAY    = Date.today.change(:year => 2009, :month => 5, :day => 3 )
MONDAY    = Date.today.change(:year => 2009, :month => 5, :day => 4 )
TUESDAY   = Date.today.change(:year => 2009, :month => 5, :day => 5 )
WEDNESDAY = Date.today.change(:year => 2009, :month => 5, :day => 6 )
THURSDAY  = Date.today.change(:year => 2009, :month => 5, :day => 7 )
FRIDAY    = Date.today.change(:year => 2009, :month => 5, :day => 8 )
SATURDAY  = Date.today.change(:year => 2009, :month => 5, :day => 9 )

Factory.sequence :login do |n|
  "user#{n}"
end

Factory.define :user do |u|
  u.login { Factory.next :login }
  u.date_of_hire Date.today
  u.max_personal 10.0
  u.max_etc 10.0
  u.max_vacation 10.0
end

time = DateTime.now

Factory.define :holiday do |h|
  h.leave_length 'many'
  h.leave_type 'etc'
  h.description "who ha"
  h.state 0
  h.reviewed_by 'rsmith'
  h.reviewed_on "#{DateTime.now}"
  h.begin_time "#{ time }"
  h.end_time "#{  time + 2.days}"
  h.association :user
end

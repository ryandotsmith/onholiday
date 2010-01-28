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

Factory.define :holiday do |h|
  h.leave_length  {'many'  }
  h.leave_type    {'etc'   }
  h.description   {'who ha'}
  h.state         {0       }
  h.reviewed_by   {'rsmith'    }
  h.reviewed_on   { DateTime.now}
  h.begin_time    { MONDAY_THIS_YEAR}
  h.end_time      { MONDAY_THIS_YEAR + 2.days}
  h.user { |user| user.association(:user)}
end

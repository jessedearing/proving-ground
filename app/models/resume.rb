class Resume
  attr_accessor :name, :objective, :technologies, :experience, :academic_activities, :education

  def initialize(hash)
    self.name = hash.keys.first
    hash = hash[self.name]
    self.objective = hash["Objective"]
    self.technologies = hash["Technologies"]
    self.experience = hash["Experience"]
    self.academic_activities = hash["Academic Activities"]
    self.education = hash["Education"]
  end
end

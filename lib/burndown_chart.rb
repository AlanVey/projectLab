class Burndown_chart

  def self.create_burndown_chart(project)
    @@project = project
    @@project_duration = (project_due_date - @@project.started_at).to_i + 1
    GoogleVisualr::Interactive::LineChart.new(process_data(initialise_table), options)
  end

  private 

    def self.options
      {:width => 800, :height => 400, :title => 'Burndown Chart', :legend => 'bottom'}
    end

    def self.process_data(table)
      milestones = @@project.milestones.order(:due_date)

      i = 1
      milestones.each do |milestone|
        table.set_cell(i, 0, milestone.due_date)
        table.set_cell(i, 1, optimal_milestone_difficulty(milestone.due_date))
        table.set_cell(i, 2, actual_milestone_difficulty(milestone.due_date))
        i += 1
      end

      table
    end

    def self.project_difficulty
      sum = 0
      @@project.milestones.each {|m| sum += milestone_difficulty(m) }
      sum
    end

    def self.milestone_difficulty(milestone)
      sum = 0
      milestone.tasks.each { |t| sum += t.difficulty }
      sum
    end

    def self.optimal_milestone_difficulty(date)
      difficulty = project_difficulty
      @@project.milestones.each {|m| difficulty -= milestone_difficulty(m) if m.due_date <= date}
      difficulty
    end

    def self.actual_milestone_difficulty(date)
      difficulty = project_difficulty
      @@project.milestones.each {|m| difficulty -= milestone_difficulty(m) if m.due_date <= date && m.status == 'Completed'}
      difficulty
    end

    def self.project_due_date
      due_date = Date.new(1990,1,1)
      @@project.milestones.each do |milestone|
        due_date = milestone.due_date if milestone.due_date > due_date
      end
      due_date
    end

    def self.initialise_table
      table = GoogleVisualr::DataTable.new
      table.new_column('date', 'Date')
      table.new_column('number', 'Optimal Path')
      table.new_column('number', 'Actual Path')
      table.add_rows(@@project.milestones.count + 1)
      
      # Initial setup
      work_hours = project_difficulty
      table.set_cell(0, 0, @@project.started_at)
      table.set_cell(0, 1, work_hours)
      table.set_cell(0, 2, work_hours)
      
      table
    end

end
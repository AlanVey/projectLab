class Burndown_chart

  def self.create_burndown_chart(project)
    @@project = project
    @@num_milestones = project.milestones.count
    GoogleVisualr::Interactive::LineChart.new(process_data(initialise_table), options)
  end

  private 

    def self.options
      {:width => 800, :height => 400, :title => 'Burndown Chart', :legend => 'bottom'}
    end

    def self.initialise_table
      table = GoogleVisualr::DataTable.new
      table.new_column('date', 'Date')
      table.new_column('number', 'Optimal')
      table.new_column('number', 'Actual')
      table.add_rows((Date.today - @@project.created_at.to_date).to_i + remaining_project_difficulty + 1)
      table
    end

    def self.process_data(table)
      sum_difficulty_optimal = project_difficulty

      # Initial setup
      table.set_cell(0, 0, @@project.created_at.to_date)
      table.set_cell(0, 1, sum_difficulty_optimal)
      table.set_cell(0, 2, sum_difficulty_optimal)

      # Optimal/Actual Line
      i = 0
      begin
        i += 1
        date = @@project.created_at.to_date + i

        table.set_cell(i, 0, date)

        # Creating optimal line points
        sum_difficulty_optimal -= 1
        if sum_difficulty_optimal <= 0
          table.set_cell(i, 1, 0)
        else
          table.set_cell(i, 1, sum_difficulty_optimal)
        end

        # Creating actual line points
        if(task_latest_updated_at < date - 1)
          constant_dec = task_difficulty_completed_by(date) - (date - task_latest_updated_at).to_i
          if constant_dec > 0
            table.set_cell(i, 2, constant_dec)
          else
            table.set_cell(i, 2, 0)
          end
        else
          table.set_cell(i, 2, task_difficulty_completed_by(date))
        end
      end while sum_difficulty_optimal != 0

      table
    end

    def self.project_difficulty
      sum = 0
      @@project.milestones.each do |milestone|
        sum += milestone_difficulty(milestone)
      end
      sum
    end

    def self.remaining_project_difficulty
      sum = 0
      @@project.milestones.each do |milestone|
        sum += milestone_difficulty(milestone) if milestone.status != 'Completed'
      end
      sum
    end

    def self.milestone_difficulty(milestone)
      sum = 0
      milestone.tasks.each {|t| sum += t.difficulty}
      sum
    end

    def self.task_difficulty_completed_by(date)
      sum = project_difficulty
      @@project.milestones.each do |milestone|
        milestone.tasks.each do |task|
          sum -= task.difficulty if task.status == 'Completed' && task.updated_at <= date
        end
      end
      sum
    end

    def self.task_latest_updated_at
      date = Date.new(1990,1,1)
      @@project.milestones.each do |milestone|
        task_date = Task.where(milestone_id: milestone.id).order('updated_at DESC').first.updated_at
        if date < task_date.to_date
          date = task_date.to_date
        end
      end
      date
    end
end
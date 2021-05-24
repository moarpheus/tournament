require 'byebug'


class Tournament
  
  Team = Struct.new(:name, :matches_played, :wins, :losses, :draw, :points) do
  end

  def self.tally input
    all = []
    input.split("\n").each do |line|
      match = line.split(";")
      team_1 = all.find {|t| t.name == match[0]}
      team_2 = all.find {|t| t.name == match[1]}
      unless team_1
        team_1 = Team.new(match[0], 0, 0, 0, 0, 0)
        all << team_1
      end
      unless team_2
        team_2 = Team.new(match[1], 0, 0, 0, 0, 0)
        all << team_2
      end
      case
      when (match.last == "win")
        team_1.wins += 1
        team_1.points +=3
        team_2.losses += 1
      when (match.last == "loss")
        team_2.wins += 1
        team_2.points +=3
        team_1.losses += 1
      when (match.last == "draw")
        team_1.draw += 1
        team_2.draw += 1
        team_1.points +=1
        team_2.points +=1
      end
        team_1.matches_played += 1
        team_2.matches_played += 1
    end
    header = "Team                           | MP |  W |  D |  L |  P"
    all.sort_by { |team| team.points }.reverse.inject([header]) do |acc, team|
      acc << "#{team.name}" + "|  #{team.matches_played} |  #{team.wins} |  #{team.draw} |  #{team.losses} |  #{team.points}".prepend(" " * (31 - team.name.length))
      acc
    end.join("\n") + "\n"
  end
end

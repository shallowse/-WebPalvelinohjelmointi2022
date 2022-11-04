# vk7/tehtävä13 ainoastaan Brewery and Style refaktoroitiin, koska niissä oli käytössä sama koodipohja
module TopRating
  def top(num)
    return [] unless num > 0

    collect = []
    all.each do |obj|
      avg_sum = []
      obj.beers.each do |beer|
        avg_sum.append(beer.average_rating)
      end

      avg_sum = [0] if avg_sum.empty?

      collect.append(OpenStruct.new(name: obj.name, rating: avg_sum.sum.to_f / avg_sum.count))
    end

    collect.sort_by! { |a| -a.rating }
    collect[0...num]
  end
end

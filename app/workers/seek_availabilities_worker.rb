class SeekAvailabilitiesWorker
  include Sidekiq::Worker

  def perform(data)
    SeekAvailabilitiesService.new(
      cat: Cat.find(data['cat_id']),
      sbcat: Sbcat.find(data['sbcat_id']),
    	typ: Typ.find(data['typ_id'])
    ).call
  end
end

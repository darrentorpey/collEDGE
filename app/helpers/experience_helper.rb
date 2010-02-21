module ExperienceHelper

  def properties_list_sentence(experience)
    %Q|It was&hellip; <span class="experience_sentence">#{experience.event.properties_list_sorted.to_sentence}</span>|
  end
end
class Priority
  DEFAULT_PRIORITY = 1000.freeze
  attr_accessor :applier, :priority

  def self.all
    YAML.load_file("priority_list.yaml").map do |priority_attrs|
      new(applier: priority_attrs.first, priority: priority_attrs[1])
    end
  end

  def self.find(applier:)
    all.find { _1.applier == applier }
  end

  def initialize(applier:, priority:)
    @applier = applier
    @priority = priority
  end
end

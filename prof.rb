require 'ruby-prof'
require 'primer/view_components'

result = RubyProf.profile do
  100_000.times do
    Primer::Classify.call({ bg: :blue_5, color: :text_warning, vertical_align: :text_bottom, display: :block, mx: 4, mb: 4 })
  end
end

printer = RubyProf::FlatPrinter.new(result)
printer.print(STDOUT, {})

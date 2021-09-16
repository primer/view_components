require 'ruby-prof'
require 'primer/view_components'

$improved = true

args = { bg: :blue_5, color: :text_warning, vertical_align: :text_bottom, display: :block, mx: 4, mb: 4 }

result = RubyProf.profile do
  100_000.times do
    Primer::Classify.call(args)
  end
end

printer = RubyProf::FlatPrinter.new(result)
printer.print(STDOUT, {})

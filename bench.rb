require 'benchmark/ips'
require 'primer/view_components'

args = { bg: :blue_5, color: :text_warning, vertical_align: :text_bottom, display: :block, mx: 4, mb: 4 }

Benchmark.ips do |x|
  x.report('original') do
    $improved = false
    Primer::Classify.call_orig(args)
  end

  x.report('improved') do
    $improved = true
    Primer::Classify.call(args)
  end

  x.compare!
end

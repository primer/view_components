# frozen_string_literal: true

namespace :static do
  task dump: [:dump_statuses, :dump_constants, :dump_audited_at, :dump_previews, :dump_arguments, :dump_info_arch]

  task dump_statuses: :init_pvc do
    Primer::Static.dump(:statuses)
  end

  task dump_constants: :init_pvc do
    Primer::Static.dump(:constants)
  end

  task dump_audited_at: :init_pvc do
    Primer::Static.dump(:audited_at)
  end

  task dump_previews: :init_pvc do
    Primer::Static.dump(:previews)
  end

  task dump_arguments: ["docs:build_yard_registry", :init_pvc] do
    Primer::Static.dump(:arguments)
  end

  task dump_info_arch: ["docs:build_yard_registry", :dump_previews, :dump_arguments] do
    Primer::Static.dump(:info_arch)
  end
end

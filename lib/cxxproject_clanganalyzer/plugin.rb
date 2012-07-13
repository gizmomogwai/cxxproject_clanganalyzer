cxx_plugin do |cpp_to_rake, building_blocks, log|

  def available?
    return `which clang++` != ""
  end

  def get_source_files(building_block)
    return building_block.sources.map { |source| File.join(building_block.project_dir, source) }
  end

  def get_includes(building_block)
    includes = []
    building_block.all_dependencies.each do |bb|
      includes += bb.includes.map{|i|File.join(bb.project_dir, i)}
    end
    return includes.uniq
  end

  def get_defines(building_block, source)
    compilers = building_block.tcs[:COMPILER] || {}
    compiler_for_type = compilers[building_block.get_source_type(source)] || {}
    defines = compiler_for_type[:DEFINES] ||= []
    return defines
  end

  if available?
    desc 'Run analyzer on all sources'
    task :analyze do
      building_blocks.each_value do |building_block|
        if building_block.is_a?(Cxxproject::HasSources)
          sources = get_source_files(building_block)
          includes = get_includes(building_block).map{|i| "-I#{i}" }.join(' ')
          sources.each do |source|
            defines = get_defines(building_block, source).map{|d| "-D#{d}" }.join(' ')
            sh "clang++ --analyze #{includes} #{defines} #{source}"
          end
        end
      end
    end
  else
    log.error "Please uninstall plugin cxxproject_clanganalyzer or install clang"
  end

end

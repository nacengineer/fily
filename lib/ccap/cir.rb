require 'benchmark'

module Ccap
  module Cir

    def get_best_cir
      Rails.cache.read('cir') || figure_out_best_cir
    end

    def figure_out_best_cir
      repo_bms = benchmark_repos
      fastest_cir_from_bms( repo_bms )
    end

    def fastest_cir_from_bms( repo_bms )
      repo_bms.sort_by {|k,v| v.real }     # sort by Benchmark::Tms#real
      fastest = repo_bms.first.first       # sort by changes repo_bms to Array
      Rails.cache.write('cir', fastest)
      fastest
    end

    # return cir_response times and cache it if not cached
    def benchmark_repos
      begin
        repos = get_datamapper_repos( false )
        repo_bm = {}
        repos.each do |k,v|
          b = Benchmark.measure { DataMapper.repository(k) { County.first } }
          repo_bm[k] = b
        end
        raise ArgumentError if repo_bm.blank?
        Rails.cache.write('cir_responses', repo_bm)
        repo_bm
      rescue ArgumentError
        "could not benchmark repos in #{__method__}"
      end
    end

    # returns an Array of available repo keys
    def get_datamapper_repos( include_default = true )
      begin
        repos = Rails.application.config.data_mapper.repositories[Rails.env]
        raise ArgumentError if repos.blank?
        repos = repos.keys
        repos.delete('default') unless include_default
        Rails.cache.write('dm_cir_repos', repos )
        repos
      rescue ArgumentError
        "#{__method__} Could not get DM repos from Rails Application Config "
      end
    end

    def expire_all_cir_caches( testing = false )
      caches = ['cir', 'dm_cir_repos', 'cir_responses']
      caches.each {|x| Rails.cache.write(x, nil)}
      after = caches.map {|x| Rails.cache.read(x) }
      return after unless testing
      # the next three lines are for tests to verify
      # each element is actually nil
      results = true
      after.each {|x| results = false unless x.nil? }
      results
    end

    def get_all_cir_caches( testing = false )
      caches = ['cir', 'dm_cir_repos', 'cir_responses']
      cache_values = caches.map {|x| Rails.cache.read(x) }
      return cache_values unless testing
      # the next three lines are for tests to verify
      # each element is actually nil
      results = true
      cache_values.each {|x| results = false if x.nil? }
      cache_values # results
    end

  end
end
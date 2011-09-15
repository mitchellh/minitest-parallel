require "minitest/unit"
require "parallel"

module MiniTest
  module Parallel
    def self.included(base)
      base.class_eval do
        alias_method :_run_suites_in_series, :_run_suites
        alias_method :_run_suites, :_run_suites_in_parallel
      end
    end

    # You can manual set the # of processes here.
    def self.parallel_processes==(procs)
      @parallel_processes = procs
    end

    # This returns the number of processes to use for executing tests
    # in parallel. This will use the manually set processes if set,
    # then fall back to the `PAR` environmental variable if that is set,
    # and finally will fall back to the number of cores you have.
    def self.parallel_processes
      return @parallel_processes if @parallel_processes
      return ENV["PAR"].to_i if ENV["PAR"]
      return ::Parallel.processor_count
    end

    def _run_suites_in_parallel(suites, type)
      result = ::Parallel.map(suites, :in_processes => MiniTest::Parallel.processor_count) do |suite|
        ret = _run_suite(suite, type)
        {
          :failures         => failures,
          :errors           => errors,
          :report           => report,
          :run_suite_return => ret
        }
      end

      self.failures = result.inject(0)  {|sum, x| sum + x[:failures] }
      self.errors   = result.inject(0)  {|sum, x| sum + x[:errors] }
      self.report   = result.inject([]) {|sum, x| sum + x[:report] }
      result.map {|x| x[:run_suite_return] }
    end
  end
end

# Hijack the MiniTest::Unit methods.
MiniTest::Unit.send(:include, MiniTest::Parallel)

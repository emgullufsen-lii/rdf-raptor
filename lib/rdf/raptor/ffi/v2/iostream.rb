module RDF::Raptor::FFI::V2
  ##
  # This class provides an I/O stream that can write to filenames, `FILE*`,
  # strings and user-defined output via callbacks.
  #
  # @see http://librdf.org/raptor/api-1.4/raptor-section-iostream.html
  class IOStream < ::FFI::ManagedStruct
    include RDF::Raptor::FFI
    layout :user_data, :pointer # the actual layout is private

    ##
    # @overload initialize(ptr)
    #   @param  [FFI::Pointer] ptr
    #
    # @overload initialize(handler)
    #   @param  [V2::IOStreamHandler] handler
    #
    # @overload initialize(file)
    #   @param  [File, Tempfile] file
    #
    def initialize(ptr_or_obj, options = {})
      ptr = case ptr_or_obj
        when FFI::Pointer
          ptr_or_obj
        when V2::IOStreamHandler
          @handler = ptr_or_obj # prevents premature GC
          V2.raptor_new_iostream_from_handler2(self, @handler)
        when File, Tempfile
          V2.raptor_new_iostream_to_filename(File.expand_path(ptr_or_obj.path))
        when false
          V2.raptor_new_iostream_to_sink()
        else nil
      end
      raise ArgumentError, "invalid argument: #{ptr_or_obj.inspect}" if ptr.nil? || ptr.null?
      super(ptr)
    end

    ##
    # Releases `libraptor` memory associated with this structure.
    #
    # @param  [FFI::Pointer] ptr
    # @return [void]
    def self.release(ptr)
      V2.raptor_free_iostream(ptr)
    end
  end # IOStream
end # RDF::Raptor::FFI::V2

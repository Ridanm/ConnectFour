# frozen_string_literal: true

require_relative '../lib/dependencies'

# This class implements the autonomous player in case of playing against the computer
class VirtualPlayer < Player
  attr_reader :name, :piece_color

  def initialize(color)
    super('Computer', color)
    # @piece_color = piece(color)
  end

  def valid_column
    print 'Is thimking...'
    sleep(1)
  end
end

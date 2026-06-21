# frozen_string_literal: true

require_relative 'dependencies'

# This module implements the four-line search
module Victory
  def all_lines
    rows + columns + diagonals
  end

  def rows
    @board.boxes
  end

  def columns
    @board.boxes.transpose
  end

  def diagonals
    descending_diagonals + ascending_diagonals
  end

  def descending_diagonals
    # On the diagonal \ the difference of its indices is constant (r_ind - c_ind)
    groups = {}
    rows.each_with_index do |row, r_ind|
      row.each_with_index do |cell, c_ind|
        (groups[r_ind - c_ind] ||= []) << cell
      end
    end
    groups.values.select { |diag| diag.size >= 4 }
  end

  def ascending_diagonals
    # On the diagonal / the sum of its indices is constant (r_ind + c_ind)
    groups = {}
    rows.each_with_index do |row, r_ind|
      row.each_with_index do |cell, c_ind|
        (groups[r_ind + c_ind] ||= []) << cell
      end
    end
    groups.values.select { |diag| diag.size >= 4}
  end
end

class AddAttachmentScreenshotToTrades < ActiveRecord::Migration
  def self.up
    change_table :trades do |t|
      t.attachment :screenshot
    end
  end

  def self.down
    remove_attachment :trades, :screenshot
  end
end

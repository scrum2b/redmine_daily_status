
module DailyStatusProjectPatch
  def self.included(base)
    base.class_eval do
      unloadable
      has_many :daily_statuses
      has_one  :pd_settings

      def todays_status
        DailyStatus.todays_status_for self
      end
      def dummy
        PdSetting.dummy self
      end
      def dummy2
        PdSetting.dummy2 self
      end
    end
  end
end

Project.send(:include, DailyStatusProjectPatch)

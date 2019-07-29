class Gig
  class SyncFromGigo

    def initialize(gigos)
      @gigos = gigos
    end

    def update
      @gigos.each do |gigo|
        if gigo.title.to_s.downcase =~ /rehearsal/
          rehearsal = Rehearsal.find_or_initialize_by(gigo_key: gigo.key)
          sync_rehearsal_from_gigo(rehearsal, gigo)
        else
          gig = Gig.find_or_initialize_by(gigo_key: gigo.key)
          sync_gig_from_gigo(gig, gigo)
        end
      end
    end

    private

    def sync_gig_from_gigo(gig, gigo)
      gig.title = gigo.title
      gig.start_time = gigo.start
      gig.end_time = gigo.end
      gig.location = gigo.location
      gig.details = gigo.details
      gig.status = gigo.status
      gig.payment = gigo.payment
      gig.synced_at = DateTime.now
      fix_confirmation_deadline(gig)
      gig.save
    rescue => e
      Rails.logger.warn("Gig::SyncWithGigo - could not sync #{gigo.title}\n#{e.message}")
    end

    def sync_rehearsal_from_gigo(rehearsal, gigo)
      rehearsal.title = gigo.title
      rehearsal.start_time = gigo.start
      rehearsal.end_time = gigo.end
      grehearsalig.location = gigo.location
      rehearsal.details = gigo.details
      rehearsal.status = gigo.status      
      rehearsal.synced_at = DateTime.now
      rehearsal.save
    rescue => e
      Rails.logger.warn("Gig::SyncWithGigo - could not sync #{rehearsal.title}\n#{e.message}")
    end

    # Fix Edge case
    # Set the confirmation_deadline to the gig start_time if it is past it
    def fix_confirmation_deadline(gig)
      if gig.confirmation_deadline && gig.start_time &&
        gig.confirmation_deadline > gig.start_time
        gig.confirmation_deadline = gig.start_time
      end
    end
  end
end

require "sqlite3"
require "httpx"
require "json"
require "time"

module JayPT
  class CVE
    attr_reader :id, :ttl_days

    def initialize(id, ttl_days: 30)
      @id = id
      @ttl_days = ttl_days
      ensure_database_exists
    end

    def fetch
      cached_data || fetch_and_cache
    end

    private

    def cached_data
      result = db.execute(
        "SELECT data, cached_at FROM cve_cache WHERE cve_id = ?",
        [id]
      ).first

      return nil unless result

      data, cached_at_str = result
      cached_at = Time.parse(cached_at_str)

      return nil if cache_expired?(cached_at)

      JSON.parse(data)
    rescue SQLite3::Exception, JSON::ParserError => e
      warn "Cache read error: #{e.message}"
      nil
    end

    def fetch_and_cache
      data = fetch_from_api
      cache_data(data) if data
      data
    end

    def fetch_from_api
      url = "https://cve.circl.lu/api/cve/#{id}"
      response = HTTPX.get(url)

      raise Error, "HTTP #{response.status}" unless response.status == 200

      JSON.parse(response.body)
    rescue HTTPX::Error, JSON::ParserError => e
      raise Error, "Failed to fetch CVE #{id}: #{e.message}"
    end

    def cache_data(data)
      db.execute(
        "INSERT OR REPLACE INTO cve_cache (cve_id, data, cached_at) VALUES (?, ?, ?)",
        [id, data.to_json, Time.now.iso8601]
      )
    rescue SQLite3::Exception => e
      warn "Cache write error: #{e.message}"
    end

    def cache_expired?(cached_at)
      Time.now - cached_at > (ttl_days * 24 * 60 * 60)
    end

    def db
      @db ||= SQLite3::Database.new(db_path)
    end

    def db_path
      File.join(__dir__, "../../data/cve_cache.db")
    end

    def ensure_database_exists
      return if File.exist?(db_path)

      db.execute <<-SQL
        CREATE TABLE cve_cache (
          cve_id TEXT PRIMARY KEY,
          data TEXT NOT NULL,
          cached_at TEXT NOT NULL
        );
      SQL
    end
  end
end

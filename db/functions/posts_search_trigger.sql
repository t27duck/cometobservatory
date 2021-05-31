CREATE FUNCTION posts_search_trigger() RETURNS trigger AS $$
BEGIN
  NEW.searchable_tsearch :=
    SETWEIGHT(to_tsvector('pg_catalog.english', COALESCE(NEW.title, '')), 'A');
  RETURN NEW;
END
$$ LANGUAGE plpgsql;

CREATE DATABASE portfolio;

-- Switch to the 'portfolio' database
\c portfolio;

-- Create or Modify the projects table
CREATE TABLE projects (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    link VARCHAR(1024),
    date_start DATE NOT NULL,
    date_end DATE
);

CREATE TABLE languages (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL UNIQUE
);

-- Create the tags table
CREATE TABLE tags (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL UNIQUE
);

-- Create the many-to-many relationship table for projects and languages
CREATE TABLE project_languages (
    project_id INT REFERENCES projects(id),
    language_id INT REFERENCES languages(id),
    PRIMARY KEY (project_id, language_id)
);

-- Create the many-to-many relationship table for projects and tags
CREATE TABLE project_tags (
    project_id INT REFERENCES projects(id),
    tag_id INT REFERENCES tags(id),
    PRIMARY KEY (project_id, tag_id)
);

-- Create the jobs table
CREATE TABLE jobs (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    date_start DATE NOT NULL,
    date_end DATE, -- This can be NULL for ongoing jobs
    is_ongoing BOOLEAN NOT NULL DEFAULT FALSE -- FALSE means it's a past job, TRUE means it's ongoing
);

-- Create the volunteers table (quite similar to jobs)
CREATE TABLE volunteers (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    date_start DATE NOT NULL,
    date_end DATE
);

-- Responsibilities table
CREATE TABLE responsibilities (
    id SERIAL PRIMARY KEY,
    job_id INT REFERENCES jobs(id) ON DELETE CASCADE, 
    responsibility TEXT NOT NULL
    -- If a responsibility can belong to either a job OR volunteer, adjustments might be needed.
);

-- References table
CREATE TABLE job_references  (
    id SERIAL PRIMARY KEY,
    job_id INT REFERENCES jobs(id) ON DELETE CASCADE,
    name VARCHAR(255) NOT NULL,
    contact_info VARCHAR(1024) NOT NULL
    -- If a reference can belong to either a job OR volunteer, adjustments would be needed.
);

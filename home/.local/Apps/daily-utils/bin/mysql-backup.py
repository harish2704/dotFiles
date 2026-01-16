#!/usr/bin/env python3

import subprocess
import datetime
import os
import gzip
import shutil
import argparse
import sys
import fnmatch

def get_args():
    parser = argparse.ArgumentParser(description="High-performance MySQL multi-database backup tool.")
    parser.add_argument("-H", "--host", default="localhost", help="MySQL Host")
    parser.add_argument("-P", "--port", default="3306", help="MySQL Port")
    parser.add_argument("-u", "--user", required=True, help="MySQL Username")
    parser.add_argument("-p", "--password", required=True, help="MySQL Password")
    parser.add_argument("-o", "--output", default="backups", help="Output directory")
    # New argument for exclusion patterns
    parser.add_argument("-x", "--exclude", action="append", default=[], 
                        help="Pattern to exclude (e.g., 'test_*' or 'tmp_'). Can be used multiple times.")
    return parser.parse_args()

def should_exclude(db_name, patterns):
    """Checks if a database name matches any provided shell-style patterns."""
    system_dbs = ('information_schema', 'performance_schema', 'sys', 'mysql', 'Database')
    if db_name in system_dbs:
        return True
    
    for pattern in patterns:
        if fnmatch.fnmatch(db_name, pattern):
            return True
    return False

def run_backup():
    args = get_args()
    
    if not os.path.exists(args.output):
        os.makedirs(args.output)

    timestamp = datetime.datetime.now().strftime("%Y%m%d_%H%M%S")
    conn_flags = ['-h', args.host, '-P', args.port, '-u', args.user, f'-p{args.password}']

    try:
        # 1. Fetch Database List
        print(f"Connecting to {args.host}...")
        proc = subprocess.run(
            ['mysql'] + conn_flags + ['-e', 'SHOW DATABASES;', '-N', '-s'],
            capture_output=True, text=True, check=True
        )
        
        raw_databases = proc.stdout.split()
        # 2. Filter databases based on patterns
        databases = [db for db in raw_databases if not should_exclude(db, args.exclude)]

        if not databases:
            print("No databases found matching the criteria.")
            return

        print(f"Starting backup for {len(databases)} databases...")

        for db in databases:
            print(f"  -> {db}...", end=" ", flush=True)
            filename = f"{db}_{timestamp}.sql.gz"
            filepath = os.path.join(args.output, filename)

            dump_cmd = [
                'mysqldump'
            ] + conn_flags + [
                '--single-transaction',
                '--extended-insert',
                '--quick',
                '--disable-keys',
                '--no-autocommit',
                db
            ]

            with subprocess.Popen(dump_cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE) as dump_proc:
                with gzip.open(filepath, 'wb', compresslevel=6) as f_out:
                    shutil.copyfileobj(dump_proc.stdout, f_out)
                
                dump_proc.wait()
                
                if dump_proc.returncode != 0:
                    error_msg = dump_proc.stderr.read().decode()
                    print(f"\nFAILED: {error_msg}")
                else:
                    print(f"OK")

    except subprocess.CalledProcessError as e:
        print(f"\nConnection Error: {e.stderr}")
        sys.exit(1)
    except Exception as e:
        print(f"\nUnexpected error: {e}")
        sys.exit(1)

if __name__ == "__main__":
    run_backup()

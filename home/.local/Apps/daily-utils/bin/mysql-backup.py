#!/usr/bin/env python3

import subprocess
import datetime
import os
import gzip
import shutil
import argparse
import sys

def get_args():
    parser = argparse.ArgumentParser(description="High-performance MySQL multi-database backup tool.")
    parser.add_argument("-H", "--host", default="localhost", help="MySQL Host (default: localhost)")
    parser.add_argument("-P", "--port", default="3306", help="MySQL Port (default: 3306)")
    parser.add_argument("-u", "--user", required=True, help="MySQL Username")
    parser.add_argument("-p", "--password", required=True, help="MySQL Password")
    parser.add_argument("-o", "--output", default="backups", help="Output directory (default: backups)")
    return parser.parse_args()

def run_backup():
    args = get_args()
    
    # 1. Setup Environment
    if not os.path.exists(args.output):
        os.makedirs(args.output)

    timestamp = datetime.datetime.now().strftime("%Y%m%d_%H%M%S")
    exclude_dbs = ('information_schema', 'performance_schema', 'sys', 'mysql', 'Database')

    # Common connection flags
    conn_flags = ['-h', args.host, '-P', args.port, '-u', args.user, f'-p{args.password}']

    try:
        # 2. Fetch Database List
        print(f"Connecting to {args.host}...")
        proc = subprocess.run(
            ['mysql'] + conn_flags + ['-e', 'SHOW DATABASES;', '-N', '-s'],
            capture_output=True, text=True, check=True
        )
        databases = [db for db in proc.stdout.split() if db not in exclude_dbs]

        # 3. Process Each Database
        for db in databases:
            print(f"Backing up: {db}...", end=" ", flush=True)
            filename = f"{db}_{timestamp}.sql.gz"
            filepath = os.path.join(args.output, filename)

            # Fast-load dump flags
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

            # Stream from mysqldump to Gzip
            with subprocess.Popen(dump_cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE) as dump_proc:
                with gzip.open(filepath, 'wb', compresslevel=6) as f_out:
                    shutil.copyfileobj(dump_proc.stdout, f_out)
                
                dump_proc.wait()
                
                if dump_proc.returncode != 0:
                    error_msg = dump_proc.stderr.read().decode()
                    print(f"\nERROR on {db}: {error_msg}")
                else:
                    print(f"Done -> {filename}")

    except subprocess.CalledProcessError as e:
        print(f"\nConnection Error: {e.stderr}")
        sys.exit(1)
    except Exception as e:
        print(f"\nUnexpected error: {e}")
        sys.exit(1)

if __name__ == "__main__":
    run_backup()

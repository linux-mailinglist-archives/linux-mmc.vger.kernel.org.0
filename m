Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A50D2FED66
	for <lists+linux-mmc@lfdr.de>; Thu, 21 Jan 2021 15:51:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731320AbhAUOsr (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 21 Jan 2021 09:48:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731749AbhAUOlK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Jan 2021 09:41:10 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 681D0C08EB28
        for <linux-mmc@vger.kernel.org>; Thu, 21 Jan 2021 06:29:26 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id g3so2863839ejb.6
        for <linux-mmc@vger.kernel.org>; Thu, 21 Jan 2021 06:29:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=6d+dhFnF8O5Dji9MI3uQGCEsi3R81Xte/6yH406EepA=;
        b=iAMU6N4iZaZA9+7UD8H8MnQtQ2Cpe3YeQRtcdIAvDIMVUVH+8jruJobsWtbta2pu9/
         TS8Em6eCbSnkRLg6QmIFMfSZ5NJiLC+P0inASmZ1ck5hcL92XvnYfrUlOIh5NEockg3M
         sngnJTujgRmBntErYNkPTd0lC5Q5BMFqfS/xZ+2i8/20XXJh1hncFJ8r/5F4dE4HO8vc
         msi5NMvm1FcfSz2eZTGnR8q8mysXQrGwM4CEPaKERmRRfWMj9G4a+EFmcV5fQkZvfVMO
         B83i0efToxwbo6fT4gVOFQj0cp9m8jld4Df7IpwukDPFpkDLwdoGd2XTiQfnKp9lWEKD
         guUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6d+dhFnF8O5Dji9MI3uQGCEsi3R81Xte/6yH406EepA=;
        b=jPktWYYZaqNEMcSCa7M3/7y1Slsj8wNaUKF44NpmVmha2ut/DSpC0dHzu5NDaqHYWG
         EdlCOpKZEDPMiC0wjcmV3uDez5YA7nzEyAhAFEewMuWSBdrmSABq72ONpp/fI5On1zRU
         1nLW7qSIntHGPjzQD8Mo2zEC0RFmUGRq1JnvyV3MovWX174mWnxVCtnbnvP7gX3Gaxpc
         17bzgKEkHQzf1Bh/QbWYOJzEJ6kIrrS9x1J52EteoUf8S9D2HrtrdcfFNvNIEi9XTC28
         JbB4YzQah7HL4+4YkD+buWjWNn04sUOEg+P9zfk8beNairOo23afgo6PWN+auKV7ZFx5
         2Y/w==
X-Gm-Message-State: AOAM530DKVVIMHZRr7SwuYUuvplOOuQZoKs93KXX21FlGLrfWqsf8jTQ
        KOPUIWcm19DerraNRX+7Tr8l1A==
X-Google-Smtp-Source: ABdhPJxCDi5bLwTWjg3Cogi17XLUs88z2mnzLi3uB5dGCnmO1AkoP5tvuP3B7w2NbRmf5F5CDrtLTw==
X-Received: by 2002:a17:906:95cf:: with SMTP id n15mr9672034ejy.178.1611239364997;
        Thu, 21 Jan 2021 06:29:24 -0800 (PST)
Received: from ls00508.pb.local ([2001:1438:4010:2540:481b:68e3:af3e:e933])
        by smtp.gmail.com with ESMTPSA id gt18sm2263684ejb.104.2021.01.21.06.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 06:29:24 -0800 (PST)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, target-devel@vger.kernel.org,
        linux-scsi@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-ide@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH 0/2] remove unused argument from blk_execute_rq_nowait and blk_execute_rq
Date:   Thu, 21 Jan 2021 15:29:03 +0100
Message-Id: <20210121142905.13089-1-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Jens,

This series remove unused 'q' from blk_execute_rq_nowait and blk_execute_rq.
Also update the comment for blk_execute_rq_nowait.

Thanks,
Guoqing

Guoqing Jiang (2):
  block: remove unnecessary argument from blk_execute_rq_nowait
  block: remove unnecessary argument from blk_execute_rq

 block/blk-exec.c                   | 13 +++++--------
 block/bsg.c                        |  2 +-
 block/scsi_ioctl.c                 |  6 +++---
 drivers/block/mtip32xx/mtip32xx.c  |  2 +-
 drivers/block/paride/pd.c          |  2 +-
 drivers/block/pktcdvd.c            |  2 +-
 drivers/block/sx8.c                |  4 ++--
 drivers/block/virtio_blk.c         |  2 +-
 drivers/cdrom/cdrom.c              |  2 +-
 drivers/ide/ide-atapi.c            |  2 +-
 drivers/ide/ide-cd.c               |  2 +-
 drivers/ide/ide-cd_ioctl.c         |  2 +-
 drivers/ide/ide-devsets.c          |  2 +-
 drivers/ide/ide-disk.c             |  2 +-
 drivers/ide/ide-ioctls.c           |  4 ++--
 drivers/ide/ide-park.c             |  2 +-
 drivers/ide/ide-pm.c               |  4 ++--
 drivers/ide/ide-tape.c             |  2 +-
 drivers/ide/ide-taskfile.c         |  2 +-
 drivers/mmc/core/block.c           | 10 +++++-----
 drivers/nvme/host/core.c           |  8 ++++----
 drivers/nvme/host/lightnvm.c       |  4 ++--
 drivers/nvme/host/pci.c            |  4 ++--
 drivers/nvme/target/passthru.c     |  2 +-
 drivers/scsi/scsi_error.c          |  2 +-
 drivers/scsi/scsi_lib.c            |  2 +-
 drivers/scsi/sg.c                  |  3 +--
 drivers/scsi/st.c                  |  2 +-
 drivers/target/target_core_pscsi.c |  3 +--
 fs/nfsd/blocklayout.c              |  2 +-
 include/linux/blkdev.h             |  5 ++---
 31 files changed, 50 insertions(+), 56 deletions(-)

-- 
2.17.1


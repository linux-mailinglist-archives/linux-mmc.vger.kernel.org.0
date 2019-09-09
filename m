Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F17FAD8BD
	for <lists+linux-mmc@lfdr.de>; Mon,  9 Sep 2019 14:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404839AbfIIMQ5 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 9 Sep 2019 08:16:57 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40568 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404832AbfIIMQ5 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 9 Sep 2019 08:16:57 -0400
Received: by mail-lj1-f194.google.com with SMTP id 7so12467042ljw.7
        for <linux-mmc@vger.kernel.org>; Mon, 09 Sep 2019 05:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cptlCQ347g/R/oxFT9VOf0f0wPB+y+T4B6Ay9zWG1MM=;
        b=MblQ3f6qW8Sm1i8qW5NiNRMcPRzExDnVXKJHg5yOSUTVndoGnT1tby42vpbVpfyE7G
         AQVWXL9lD++XGK8XR177xahdz2UHQDZofcLU/PUv3KhoVX+FuVrjchvCfR5RtY42uULZ
         5LY0Hcx1yA0GCi2UxUZY1bRnkswW0rvRCClufMtWBl0o+iHVlJOhr5XJB8pVZTHYx40a
         wLbUHwey6zm7dpGAF+5SRgS7NOvff4uY1Hu0d1fDHfLYJ6pvF4jERFChMR2orzktwJUY
         xHlBQGYUZ1ZkQFgZSjkVYeKk9GAENJMZFcfE/SzFyZQPyTUbvu/JQgVJDlpJLJMLsBmF
         0CUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cptlCQ347g/R/oxFT9VOf0f0wPB+y+T4B6Ay9zWG1MM=;
        b=SoSSZ6uN09C2pa9zZhKtePS/zC8bKSjKeM9vbgOjQ5FIf2WKHAEUCZ+s28YqQk5lHe
         ZYmm2gHYJzKr1dEIEA9TdMf1HUcoOWiH9/00TEVgEsK2npBW+EdhZaKjLJz/EpdTrnRL
         BQc9yAvs5Z0A7Rp3RSJ1ce/lXZwvzGzyY8NE7dyueTzMsUcUTltSfyGsgjxOWVH4/AoC
         P4fWHTmBnPudiptOTaYx7NXB98jyGgY2WGQtX2PTkmKnbWv4C3X/NElLQB3poJRom3ld
         B2TsPv5fpa0L05vIzBdTAYqv/iEARDRER43JeI4saonh+cEKlh+wzK8bcfpiID1FIsiL
         ZflQ==
X-Gm-Message-State: APjAAAUD8YK4RE6+HAFXLQ7wQs6Kvk79ZREsxaYUa0V1/W3EIj3M/y7t
        HFA8IStYzQRg8mvIaqPELDF3W9CN8GLpHGA5CM56AQ==
X-Google-Smtp-Source: APXvYqxD1HgwI3Ux3FuXQczreEPhWMnP1kFxwAJJ1OlX8aR2HqW3YVNGQT2/PewJjfBPRtyq5gXk7bMF6Sf+iQA1sgc=
X-Received: by 2002:a2e:8091:: with SMTP id i17mr9692244ljg.13.1568031415705;
 Mon, 09 Sep 2019 05:16:55 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1567740135.git.baolin.wang@linaro.org> <14599f7165f23db2bf7b71a2596e808e2bc2056c.1567740135.git.baolin.wang@linaro.org>
 <3bcd69fd-2f8e-9b87-7292-4b0b1aa5be78@intel.com>
In-Reply-To: <3bcd69fd-2f8e-9b87-7292-4b0b1aa5be78@intel.com>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Mon, 9 Sep 2019 20:16:43 +0800
Message-ID: <CAMz4kuKsk7ZN2BnD4zp53PQE22jD-BTsJLL53SL3ndZ5=OCHYA@mail.gmail.com>
Subject: Re: [PATCH 2/4] mmc: Add virtual command queue support
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, riteshh@codeaurora.org,
        asutoshd@codeaurora.org, Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Adrian,

On Mon, 9 Sep 2019 at 20:02, Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 6/09/19 6:52 AM, Baolin Wang wrote:
> > Now the MMC read/write stack will always wait for previous request is
> > completed by mmc_blk_rw_wait(), before sending a new request to hardware,
> > or queue a work to complete request, that will bring context switching
> > overhead, especially for high I/O per second rates, to affect the IO
> > performance.
> >
> > Thus this patch introduces virtual command queue interface, which is
> > similar with the hardware command queue engine's idea, that can remove
> > the context switching.
>
> CQHCI is a hardware interface for eMMC's that support command queuing.  What
> you are doing is a software issue queue, unrelated to CQHCI.  I think you

Yes.

> should avoid all reference to CQHCI i.e. call it something else.

Since its process is similar with CQHCI and re-use the CQHCI's
interfaces, I called it virtual command queue. I am not sure what else
name is better, any thoughts? VCQHCI? Thanks.

--
Baolin Wang
Best Regards

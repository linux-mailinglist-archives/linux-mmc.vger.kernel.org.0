Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 439B247E18E
	for <lists+linux-mmc@lfdr.de>; Thu, 23 Dec 2021 11:37:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243225AbhLWKhz (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 23 Dec 2021 05:37:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239587AbhLWKhy (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Dec 2021 05:37:54 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 529FFC061756
        for <linux-mmc@vger.kernel.org>; Thu, 23 Dec 2021 02:37:54 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id k27so8364421ljc.4
        for <linux-mmc@vger.kernel.org>; Thu, 23 Dec 2021 02:37:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NooY7VWd2q7CMKzcvbSrHgi6Joedp4FNLlImZ28IvRM=;
        b=ppTjzL7uciLxL5McjTOPj82G97nQCK+4+ti+AddGuF/QK2SZXyDJYf8s3N6zenPk8I
         JwVvccqvluH/2MEBhX1/wagxbSrcRxTAocV6aVrEB6ttzFJkY6hIYmpzlNbAhcEKz5Ws
         p7Rab2cjcHkT3Hy5trO3+xXSzgeEKB7yHYUdosmp2R35jsRuhp+w7S5jFcuj0N9wfhr3
         u/b63ewJgG1sRSYWWkOPeiqfQfBKEu+6Iq4qv9X4pBM2zHeBnFBSobrKtWDxE3/PHmaG
         nShldTK2MPsiIKDUHglZj0frsOW+zVYUo6Rz8G4c1aAy9fFLwYJDyYqqBE3zp0LSa+Ku
         MYvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NooY7VWd2q7CMKzcvbSrHgi6Joedp4FNLlImZ28IvRM=;
        b=ovDDTnuwFUxshFLFs+QIiborkL7ZSTbMdq32w2dyEZs6D7mGZpebEVJvWRGVEb3RmO
         UMxP4+TdWBob+D2bfyj0Z4rZ69q3LkGppNwpTUZZ9qNYGABKHzGYY4ugd9Qn8SafGZ7M
         upH0IUSOppRYlYZKMMCPeFGmHy85X2fAc0nWOk3LKizncyu9c17Kr6/xh2TtgwDg/T/s
         hxGY1TuayP8yz1KGNDmxDe77U8qp5bxvO+uDPTxeCIlIZu6eGSLt4ZiBzYXo+Ua2Tk5L
         tSJrcTrfeZW6+pUcSlzTlUVeBnOsQ98Qck4ZTdfbq7+5AQeMIFwyBlJECgABWmPYc7lB
         U/PQ==
X-Gm-Message-State: AOAM533DiKwkj98ILqHgF5kqKfgIeVy5q0urgYAphdE3oov/ufFObMN2
        rAHc5mc9+KVuLaEdaaUfZbwNoFm1oyg3mHyGknS6Xg==
X-Google-Smtp-Source: ABdhPJzk2GNhfEySEWx3gfIENohznncf+yNL65rLt4PqlcOnc4e6w0nPQjd7eQKNYa3gb5C/QxJ1zhgacTpY4GTJvMU=
X-Received: by 2002:a2e:9915:: with SMTP id v21mr1265882lji.273.1640255872483;
 Thu, 23 Dec 2021 02:37:52 -0800 (PST)
MIME-Version: 1.0
References: <8e61aed5f64e434abc1d7b6f81859c8a@realtek.com> <CAPDyKFrLpim75nUB7ksDie2edkWsnFSq6TbFSFFpw5cY5d4y1w@mail.gmail.com>
 <fabaed5751f04105a9719c1cb0390c98@realtek.com>
In-Reply-To: <fabaed5751f04105a9719c1cb0390c98@realtek.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 23 Dec 2021 11:37:16 +0100
Message-ID: <CAPDyKFr3NRUgfKtkb2DBrhziekFAB0jT_X3Fsfvjk_bGZLC9mA@mail.gmail.com>
Subject: Re: [PATCH v3] mmc: rtsx: improve performance for multi block rw
To:     Ricky WU <ricky_wu@realtek.com>
Cc:     "tommyhebb@gmail.com" <tommyhebb@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 23 Dec 2021 at 11:27, Ricky WU <ricky_wu@realtek.com> wrote:
>
> > -----Original Message-----
> > From: Ulf Hansson <ulf.hansson@linaro.org>
> > Sent: Tuesday, December 21, 2021 8:51 PM
> > To: Ricky WU <ricky_wu@realtek.com>
> > Cc: tommyhebb@gmail.com; linux-mmc@vger.kernel.org;
> > linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH v3] mmc: rtsx: improve performance for multi block rw
> >
> > On Tue, 21 Dec 2021 at 13:24, Ricky WU <ricky_wu@realtek.com> wrote:
> > >
> > > Improving performance for the CMD is multi-block read/write and the
> > > data is sequential.
> > > sd_check_multi_seq() to distinguish multi-block RW (CMD 18/25) or
> > > normal RW (CMD 17/24) if the CMD is multi-block and the data is
> > > sequential then call to sd_rw_multi_seq()
> > >
> > > This patch mainly to control the timing of reply at CMD 12/13.
> > > Originally code driver reply CMD 12/13 at every RW (CMD 18/25).
> > > The new code to distinguish multi-block RW(CMD 18/25) and the data is
> > > sequential or not, if the data is sequential RW driver do not send CMD
> > > 12 and bypass CMD 13 until wait the different direction RW CMD or
> > > trigger the delay_work to sent CMD 12.
> > >
> > > run benchmark result as below:
> > > SD Card : Samsumg Pro Plus 128GB
> > > Number of Samples:100, Sample Size:10MB <Before> Read : 86.9 MB/s,
> > > Write : 38.3 MB/s <After>  Read : 91.5 MB/s, Write : 55.5 MB/s
> >
> > A much nicer commit message, thanks a lot! Would you mind running some
> > additional tests, like random I/O read/writes?
> >
> > Also, please specify the benchmark tool and command you are using. In the
> > meantime, I will continue to look at the code.
> >
>
> The Tool just use Ubuntu internal GUI benchmark Tool in the "Disks"
> and the Tool don't have random I/O to choice...
>
> Do you have any suggestion for testing random I/O
> But we think random I/O will not change much

I would probably look into using fio, https://fio.readthedocs.io/en/latest/

Another option that I use frequently is iozone, https://www.iozone.org.
Here's a command line that I often use for iozone
./iozone -az -i0 -i1 -s 20m -y 16k -q 4m -I -f /mnt/sdcard/iozone.tmp -e

[...]

Kind regards
Uffe

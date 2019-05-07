Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA50716BD5
	for <lists+linux-mmc@lfdr.de>; Tue,  7 May 2019 22:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbfEGUAu (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 7 May 2019 16:00:50 -0400
Received: from mail-lj1-f174.google.com ([209.85.208.174]:42409 "EHLO
        mail-lj1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726600AbfEGUAt (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 7 May 2019 16:00:49 -0400
Received: by mail-lj1-f174.google.com with SMTP id y10so8935147lji.9
        for <linux-mmc@vger.kernel.org>; Tue, 07 May 2019 13:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AhQwhnya1lWygBDHTyZELUjYoXrZkk+CaLqHSwtab4c=;
        b=Kzfmjw2pW4usOCMfxQJPbjeEqilKVI0LIcgtA3kJVJ4Tw96sTmBz9uiCgpLPOTX7xD
         j4I1H3U2sRyVayV2ZslkIpPQyUvnuFn+ALVfkFMVLcmpWfSf9pjRC5O2dyzbfK/ptt5P
         YNY442A4WUln5tqotbDtt/9LCbsuFtT0ligaI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AhQwhnya1lWygBDHTyZELUjYoXrZkk+CaLqHSwtab4c=;
        b=lRdGwkGcxxj92f8gRUZBQEpDq9jz9hP3j6HqyEMiTmAsYFek9O4WyhPVIuZ36cePcU
         He0ym82d9CQiQQvS+TaVvTdVeIArvgRIRL4+nUYIKn13lrBTimXNc5IGMyGOCNJuuu/s
         AKRZjzH7+9Zc/2mb7WdaoA0+IERn1nX5tJdo1GDf/s9qy08SJtjcmO8/jiVL6t2m0Us4
         1x+bEj7Nzmh0d6zH8tiAbOzgkolbu1nfa49VB/ILNhrIStBU1kCbce/0QyeYVyRtkjwG
         wjMa9BaUEYV3BuPP7buHtkksRMQ5dvosP8IGtQObK2zvK9vPmyQ2Y+GimeIDVB7rl7Dj
         o3wg==
X-Gm-Message-State: APjAAAVWmeFfuPeOVCx4dzSjlO9M80VqzgOnjpqEnmF6xRLZDoRmIqPF
        Tyn576L+H/r+sY5jaZlsZyUSo6MlYdg=
X-Google-Smtp-Source: APXvYqxVJnq+p7GjVsf0eJxqAb32woeFhP7xvVpTjRw8eRdzqDOeFa40mplmCN23Koy4+AuI/Z+g3g==
X-Received: by 2002:a2e:a308:: with SMTP id l8mr13717801lje.130.1557259246524;
        Tue, 07 May 2019 13:00:46 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id w19sm3551500lfk.56.2019.05.07.13.00.45
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 13:00:45 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id x132so1840628lfd.0
        for <linux-mmc@vger.kernel.org>; Tue, 07 May 2019 13:00:45 -0700 (PDT)
X-Received: by 2002:a19:ec07:: with SMTP id b7mr11898917lfa.62.1557259245003;
 Tue, 07 May 2019 13:00:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190507063634.8389-1-ulf.hansson@linaro.org>
In-Reply-To: <20190507063634.8389-1-ulf.hansson@linaro.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 7 May 2019 13:00:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh+d+dWT6g6DO5QgZkp_CAFJyXt7RPtXn59=c8bvdKtKA@mail.gmail.com>
Message-ID: <CAHk-=wh+d+dWT6g6DO5QgZkp_CAFJyXt7RPtXn59=c8bvdKtKA@mail.gmail.com>
Subject: Re: [GIT PULL] MMC and MEMSTICK updates for v5.2
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, May 6, 2019 at 11:36 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> Here's the PR with MMC updates for v5.1. This time and onwards I will continue
> to include changes also for the MEMSTICK subsystem in the PR, please tell me if
> you prefer another setup.

I'll just consider it all "MMC", not worrying about the memory stick
part. I'm assuming it's not going to be all that active or noticeable
in the big picture anyway... Sending them together sounds fine to me.

Thanks,

                 Linus

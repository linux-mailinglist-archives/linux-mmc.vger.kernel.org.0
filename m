Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B81CB7AD0
	for <lists+linux-mmc@lfdr.de>; Thu, 19 Sep 2019 15:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388242AbfISNuB (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 19 Sep 2019 09:50:01 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39086 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387924AbfISNuB (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Sep 2019 09:50:01 -0400
Received: by mail-lj1-f196.google.com with SMTP id y3so2284107ljj.6
        for <linux-mmc@vger.kernel.org>; Thu, 19 Sep 2019 06:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0KI50c5DVE3uwnA2Yo5W/sRZ/AbTOBQXWS/KDcSVNcs=;
        b=QlfLRPU2XPxXFwAPvQajEriBO0hzz6U91rb0O4khV0WMcadCiYyfz044sHQiJ/Zp3E
         Ypl4dbggH9gZy7T3z48RvKTVmNbugho48jRt4JaYgmxzNEiLLGXQuDMdXdprMJTUIKBv
         Rta9CpiJS6V7gZOl3Xf5nOvjK1EpCSp0GV4Qrb5Ot1g5GMdGG1j3CZeoqOJ4rQUWY8/H
         XGZKGWawL5Wafw3yqFehSHxNmYdJcBkzWWph15d6Z+flDZsApQuexNcL+DfbY3iZRSqa
         054rmTCXKGLGH4LBRaC3VPdHqXox6cxPvxiJpGH3/EG69cB6QxSdVAk3vV/rFxV6ou/Q
         Jd1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0KI50c5DVE3uwnA2Yo5W/sRZ/AbTOBQXWS/KDcSVNcs=;
        b=hA06SFiFPPg9v5ARJXVAgRjlHAAPNlHP0skoOCpxMVZ1MV80wOgTIKmQJkUcJ+0iCm
         LnIYU2fTVntlHYhzVU1YIsXrY/LvvQVKLmqZAqF9VBwStRYTRbyafv/f03J/qph+T74i
         usG/H1YzJbMH3kby5kfkB5zDLp2qjoMo94AIOpcWjoC2zzJROsmcB+V4ZQYg8oBi/hB6
         WSZt1t/pj8WAP+NiZ5tniThdVyzuPguw0uSMzGhdSSejq1oV0R8xrQtg4s5PTF6iwJYK
         cxrclcs9Hk58XgKdasAaxRB5cuVlPv1VD8HYJsV4o3kxXvbo7kK8AO59USJt/tK5dixP
         kr/g==
X-Gm-Message-State: APjAAAVHapup9kV4HsxO2Jxdqk2Xud9gNcnhgHZQbm0VAXqleOtWKopH
        +cTdd5VnV2+mmXZ8qVsHMj8N9gWwFqBUrTPmcdylkoI5Zlc=
X-Google-Smtp-Source: APXvYqzcD9JqNlfx0nTWpYF6LRWekyOrrs/+lRmyoXbBw6JTsPssmUhILIrw+w8Q7QmzxQ3gy2Ew2vzi8qvmPQwmRl4=
X-Received: by 2002:a2e:9015:: with SMTP id h21mr5673483ljg.234.1568900999256;
 Thu, 19 Sep 2019 06:49:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190912210509.19816-1-mhei@heimpold.de> <MN2PR04MB6991CE61681D33F1F7E76ADAFC890@MN2PR04MB6991.namprd04.prod.outlook.com>
In-Reply-To: <MN2PR04MB6991CE61681D33F1F7E76ADAFC890@MN2PR04MB6991.namprd04.prod.outlook.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 19 Sep 2019 15:49:22 +0200
Message-ID: <CAPDyKFrae36rymcD-o9RELiWVTzMd-ccM2q1q-dO7GiWYaqw+w@mail.gmail.com>
Subject: Re: [PATCH mmc-utils v2 0/5] Various fixes for mmc-utils
To:     Avri Altman <Avri.Altman@wdc.com>
Cc:     Michael Heimpold <mhei@heimpold.de>,
        "chris@printf.net" <chris@printf.net>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 19 Sep 2019 at 11:41, Avri Altman <Avri.Altman@wdc.com> wrote:
>
> Ulf/Adrian,
>
> As Chris is less responsive in the past few years,
> We might want to follow the scsi ML practice with regard to the ufs driver:
> Add several reviewers while Martin is pulling the patches.

This has been discussed earlier [1] and Chris also agreed that it
seems like a good idea.

>
> It is working quite well since then.
>
> Is this something that you might consider?

As said, it's been discussed. I think it boils down to that someone
must volunteer to help Chris. Then it's just a matter of formalizing
this, set up git push permissions and document the new ways of
maintenance.

Perhaps you would be interested to help out?

[...]

Kind regards
Uffe

[1]
https://patchwork.kernel.org/patch/10709543/

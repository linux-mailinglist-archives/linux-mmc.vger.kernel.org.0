Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36845A1B7E
	for <lists+linux-mmc@lfdr.de>; Thu, 29 Aug 2019 15:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbfH2Nee (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 29 Aug 2019 09:34:34 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:34339 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbfH2Nee (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 29 Aug 2019 09:34:34 -0400
Received: by mail-vk1-f193.google.com with SMTP id h192so785483vka.1
        for <linux-mmc@vger.kernel.org>; Thu, 29 Aug 2019 06:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pbfLO54fkGctW6Jh5DnT6FdY0NlRCtGGlA8ihlh8Bok=;
        b=cdiyZKw0FGDeXSaVtsL/dSzTBl/kvpt04wB3NRBsSPjBkldExDztFzwE13fsj+VK2t
         uF/YiKCuaLyK0iXIfwZn7zxeat6x25HBEJmKTTMrDIz0CBQ1Jx1r+y3x6ZuGzxOVJP8K
         TwITrVKBmm9AG4hp747UBzsTVCOuvHxyFKVsjTNY4SSVWSCOuzE2iqNbFpnbjDyZ5B6y
         uQZx+T6JseAnbRJwF8kxrcfaOXCjkS6W7nGnvpuNDR0Z5X7o3++Mj/fiW2HeoozAPUX7
         vSh+bLSwpkq6whrzBhWz0Y950Ik4iVK6nEdDVnujiHqUYicqb3efzinJYIzs75Y6+A4Q
         CUqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pbfLO54fkGctW6Jh5DnT6FdY0NlRCtGGlA8ihlh8Bok=;
        b=LG9knndkgQphXxMiO6vzyw6PoqPHIVbYW6TWr9LaEfjb90dZvc8Y9QRUigVZR2ma6k
         s7NqFsi84K47DK/bKdFXMkM6/Sa/mfagjHM12+oo0woSZXwJ+XrX/KQ7XUTRRMTOIw/t
         eGIh7IfSIKegOYXgyTjNriC3u+iUItSKSE/xLYUG944KLIDkATIdX9i9sQjPCGUc9Mke
         nV9F1iExprJtTiJHYarExJQzKEIsOFjJQb8byXko+VeTMjynW5vMQulwXwUgaboK4Qy9
         VtEuoqKnvHmeYhgncXmV1tjlYUBSj72WzyY67FeqYrzjBXC6GjBszX8tcXqGGzk6oJHM
         BxZQ==
X-Gm-Message-State: APjAAAVgHL3P2gbmuCSEXMWhayVDeDGtjTmF4pnGi63SgF2IGhnJ2uQ9
        1Mo1C8EhUbT7cOCtW0rOmcm6ueLSEz9Q5yVUuXSNeg==
X-Google-Smtp-Source: APXvYqw3HfMlQaaV5odaBdhqNULZD49UIPaZWvI5kKcX2CisbjLnSx21IzTNY/UjLpa/TPN23TyOblgIqgzNwJOHReo=
X-Received: by 2002:a1f:5185:: with SMTP id f127mr5041539vkb.52.1567085673102;
 Thu, 29 Aug 2019 06:34:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190827003145.2249-1-benchuanggli@gmail.com>
In-Reply-To: <20190827003145.2249-1-benchuanggli@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 29 Aug 2019 15:33:57 +0200
Message-ID: <CAPDyKFpL0AibOOu571J6Trad=SddxFZ5JaMLRu23K4-OkcEEZw@mail.gmail.com>
Subject: Re: [PATCH V6 0/5] Add Genesys Logic GL975x support
To:     Ben Chuang <benchuanggli@gmail.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Michael K. Johnson" <johnsonm@danlj.org>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 27 Aug 2019 at 02:32, Ben Chuang <benchuanggli@gmail.com> wrote:
>
> From: Ben Chuang <ben.chuang@genesyslogic.com.tw>
>
> The patches modify internal clock setup to match SD Host Controller
> Simplified Specifications 4.20 and support Genesys Logic GL9750/GL9755 chipsets.
>
> V6:
>  - export sdhci_abot_tuning() function symbol
>  - use C-style comments
>  - use BIT, FIELD_{GET,PREP} and GENMASK to define bit fields of register
>  - use host->ops->platform_execute_tuning instead of mmc->ops->execute_tuning
>  - call sdhci_reset() instead of duplicating the code in sdhci_gl9750_reset
>  - remove .hw_reset
>  - use condition define CONFIG_MMC_SDHCI_IO_ACCESSORS for read_l

Applied patch 1-4, deferring patch5 for another version to fix Adrian's comment.

Kind regards
Uffe

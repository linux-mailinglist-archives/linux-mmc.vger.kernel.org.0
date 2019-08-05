Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A96B58230E
	for <lists+linux-mmc@lfdr.de>; Mon,  5 Aug 2019 18:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728818AbfHEQtX (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 5 Aug 2019 12:49:23 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:32975 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728800AbfHEQtX (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 5 Aug 2019 12:49:23 -0400
Received: by mail-io1-f68.google.com with SMTP id z3so27570117iog.0
        for <linux-mmc@vger.kernel.org>; Mon, 05 Aug 2019 09:49:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Iy0zgi7c5Mt6BCyigJ+sau0NZkAGLjojiGbTtlpXmX4=;
        b=SGoFnGh6OBqQV9eEa9uXILOEqJE8mSEdnIsSry/DRGUI5DiDOqODkIS0c9K82Nes92
         Rtlqix7tIKkmb/ZXdfE2gKNY9m3Q8uDPpFoutP+m09X+ydszUz2tZ6m/DHTw4NnQ1rR9
         QlJYZsLQOI2v5hK3QhMKZnDFp+zWjaJm10MzXc+F2XW2GpF1ER105Qr+PB3A74rQQ2o7
         pO/KEGNboKckjrsIlxYm+bwEeO0pvrjWUMqLAMEhEA83acnhOvwWWKrW1QEeIXMNnxQN
         m4bsx0ySZT/Cbrd0AeAQ7X50UocoyITmB1uIPX+cfhfBKEdaBQzcDMaDdqb+jx5wik7O
         lYkg==
X-Gm-Message-State: APjAAAXjv/HRtbMVsQF8KfC2P5OPULRve6x2/Wo69mdZagEjEeH1FZ2Z
        StCmtN949vNcZFjrqywaqyQh2Q==
X-Google-Smtp-Source: APXvYqylsgW6+SJQlfTE/tTlTjRGeYSraVjmnVSRxvw6S4E37w75djUCGF7oXf/2sEbet6SG4H43dw==
X-Received: by 2002:a02:c6a9:: with SMTP id o9mr101484652jan.90.1565023762315;
        Mon, 05 Aug 2019 09:49:22 -0700 (PDT)
Received: from google.com ([2620:15c:183:0:5118:89b3:1f18:4090])
        by smtp.gmail.com with ESMTPSA id e188sm75590176ioa.3.2019.08.05.09.49.20
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 05 Aug 2019 09:49:21 -0700 (PDT)
Date:   Mon, 5 Aug 2019 10:49:17 -0600
From:   Raul Rangel <rrangel@chromium.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Daniel Kurtz <djkurtz@chromium.org>,
        hongjiefang <hongjiefang@asrmicro.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Kyle Roeschley <kyle.roeschley@ni.com>,
        Avri Altman <avri.altman@wdc.com>
Subject: Re: [RFC PATCH 1/2] mmc: sdhci: Manually check card status after
 reset
Message-ID: <20190805164917.GA93879@google.com>
References: <20190501175457.195855-1-rrangel@chromium.org>
 <CAPDyKFpL1nHt1E1zgS-iDZf_KDWk2CN32Lvr+5Nmo8CtB2VCWg@mail.gmail.com>
 <20190607160553.GA185100@google.com>
 <CAPDyKFout6AY2Q92pYQ-KPH0NENq1-SkYivkDxjjb=uB=tKXuQ@mail.gmail.com>
 <20190610163252.GA227032@google.com>
 <fcdf6cc4-2729-abe2-85c8-b0d04901c5ae@intel.com>
 <20190619145625.GA50985@google.com>
 <20190801151624.GA155392@google.com>
 <a9a8d3f5-d600-7c8d-8734-cf6a017849c5@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9a8d3f5-d600-7c8d-8734-cf6a017849c5@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, Aug 02, 2019 at 07:58:20AM +0300, Adrian Hunter wrote:
> 
> You seem not to have answered to my suggestion for a change to sdhci_reinit() here:
> 
> 	https://lore.kernel.org/lkml/fcdf6cc4-2729-abe2-85c8-b0d04901c5ae@intel.com/
> 
I thought I answered it here: https://lore.kernel.org/lkml/20190619145625.GA50985@google.com/#t

Did I miss something?

Thanks
